import os, logging, subprocess
from datetime import datetime as dt
from utils.configs import CNFG
from utils.type_hints import Literal
from winsound import PlaySound, SND_ALIAS
from codecarbon import EmissionsTracker

import warnings
warnings.filterwarnings("ignore")


def set_logger(log_file: str = CNFG.log_file) -> logging.Logger:
    """
    Sets up a logger to write logs to a file.

    Parameters:
        log_file (str): The file path where the logs should be written.

    Returns:
        logging.Logger: The configured logger object.
    """
    logger = logging.getLogger('')
    logger.setLevel(logging.INFO)  # Set the minimum level of logs to capture
    # Prevent the logger from propagating to the root logger
    logger.propagate = False
    # Create a file handler to write logs to a file
    # The 'a' mode means logs will be appended to the file
    file_handler = logging.FileHandler(log_file, mode= 'a')
    # Create a formatter to define the log message format
    formatter = logging.Formatter('%(asctime)s | %(message)s')
    file_handler.setFormatter(formatter)
    # Add the file handler to the logger, but only if it doesn't have handlers already
    if not logger.handlers:
        logger.addHandler(file_handler)

    return logger


def timestamp() -> str:
    """
    Returns the current date and time as a formatted string.
    The format of the returned string is: YYYY-MM-DD_HH-MM-SS (e.g., 2023-10-27_15-30-00).
    This function can be useful for generating unique identifiers or logging events with
    a timestamp.

    Returns:
        str: The current date and time formatted as a string in the specified format.
    """
    return dt.now().strftime("%H:%M:%S")


def create_folder(path: str) -> None:
    """
    Creates a directory at the specified path if it does not already exist.
    This function checks if the directory specified by the 'path' parameter exists.
    If it does not exist, the function creates the directory. If the directory already
    exists, the function will delete the directory and create a new one.

    Parameters:
        path (str): The file system path where the folder should be created.

    Returns:
        None: This function does not return any value.

    Raises:
        OSError: If an error occurs while creating the directory (e.g., permission denied).
    """

    if os.path.exists(path):
        os.removedirs(path)
        os.makedirs(path)
    else:
        os.makedirs(path)


def delete_file(file_path: str) -> None:
    """Deletes a file if the file exists.

    Parameters:
        file_path (str): The path to the file to be deleted.

    Returns:
        None: This function does not return any value.
    """
    if os.path.exists(file_path):
        os.remove(file_path)


def set_priority(priority: Literal['Real Time', 'High', 'Above Normal', 'Below Normal', 'Low', 'Idle'] = 'High') -> None:
    """
    Sets the priority level of the current process.
    This function changes the priority of the process identified by its process ID (PID).

    Parameters:
        priority (Literal): The desired priority level for the process.
                            Must be one of the following: 'Real Time', 'High', 'Above Normal', 'Below Normal', 'Low', or 'Idle'.
                            Default priority is High.

    Returns:
        None: This function does not return any value.

    Raises:
        subprocess.CalledProcessError: If the command to set the priority fails.
    """
    pid: str = str(os.getpid())
    command: str = f"wmic process where processid='{pid}' CALL setpriority '{priority}'"
    subprocess.run(command, shell=True, stdout=subprocess.DEVNULL, stderr=subprocess.DEVNULL)

def passs_1():
    pass


def add_log(logger: logging.Logger, text: str, sound_file: str|None = None) -> None:
    """
    Adds a message to the logger and optionally plays a sound.

    Parameters:
        logger (logging.Logger): The logger object to which the message should be added.
        text (str): The message to be added to the logger.
        sound_file (str | None): The file path of the sound to be played. If None, no sound will be played.

    Returns:
        None: This function does not return any value.
    """

    if text not in [None, '', ' ']:
        print(f'{timestamp()} | {text}')
        logger.info(text)
        if sound_file:
            PlaySound(sound=sound_file, flags=SND_ALIAS)
    else:
        print("text parameter must not be empty")


def start_emissions_tracker(logs: bool = False) -> EmissionsTracker:
    """
    Starts a CO2 tracker using the codecarbon library.

    Parameters:
        logs (bool): Whether to log the CO2 emissions. Default is False.

    Returns:
        EmissionsTracker: The started CO2 tracker object.
    """
    if not logs:
        logging.getLogger("codecarbon").setLevel(logging.ERROR)

    tracker: EmissionsTracker = EmissionsTracker()
    tracker.start()
    return tracker


def collect_emissions(tracker: EmissionsTracker, stop: bool = False) -> float:
    """
    Stops or flushes a CO2 tracker using the codecarbon library.

    Parameters:
        tracker (EmissionsTracker): The CO2 tracker object to be stopped.
        stop (bool): Whether to stop the tracker. Default is False.
    Returns:
        float: The total CO2 emissions in kg.
    """
    if stop:
        return tracker.stop()
    else:
        return tracker.flush()


def improved_ndvi(bands: list[float]) -> float:
    """
    Calculates the Enhanced Vegetation Index (EVI), an optimized vegetation index.

    According to the optical-earth-observer skill, EVI is preferred over NDVI for high biomass regions
    as it decouples the canopy background signal and reduces atmospheric influences.

    Formula: G * (NIR - Red) / (NIR + C1 * Red - C2 * Blue + L)
    Where G=2.5, C1=6, C2=7.5, L=1.

    Parameters:
        bands (list[float]): Reflectance values ordered as [Red, NIR, Blue].
                             Expected wavelengths: Red (~670nm), NIR (~850nm), Blue (~470nm). 
                             If only [Red, NIR] are provided, calculates SAVI.

    Returns:
        float: The calculated EVI (or SAVI) value.
    """
    if len(bands) < 2:
        raise ValueError("improved_ndvi requires at least [Red, NIR] for SAVI or [Red, NIR, Blue] for EVI.")

    red = float(bands[0])
    nir = float(bands[1])

    if len(bands) >= 3:
        # Calculate EVI (Requires Blue band)
        blue = float(bands[2])
        
        G = 2.5
        C1 = 6.0
        C2 = 7.5
        L = 1.0

        denominator = nir + (C1 * red) - (C2 * blue) + L
        
        if denominator == 0:
            return 0.0

        return G * ((nir - red) / denominator)
    
    else:
        # Fallback to SAVI (Soil Adjusted Vegetation Index)
        # Suitable when Blue band is unavailable
        L = 0.5
        denominator = nir + red + L
        if denominator == 0:
            return 0.0
            
        return (1 + L) * (nir - red) / denominator
