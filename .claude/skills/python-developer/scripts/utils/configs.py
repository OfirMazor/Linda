from os import cpu_count

class CNFG:

    main_folder: str = r"C:\Users\ofirm\Desktop\PyCharm\TemplateProject/"

    log_folder: str = fr"{main_folder}logs/"

    log_file: str = fr"{log_folder}/log.txt"

    nCPU: int = cpu_count()


class Sounds:

    info: str = r"C:\Users\ofirm\Downloads\new.wav"
    warning: str = r"..."
    error: str = r"..."
    success: str = r"..."