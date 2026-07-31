param(
    [int]$Port = 5173,
    [string]$SignalFile = "$env:TEMP\linda-splash-ready.signal",
    [int]$TimeoutSeconds = 60
)

Add-Type -AssemblyName PresentationFramework
Add-Type -AssemblyName PresentationCore
Add-Type -AssemblyName WindowsBase

$scriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path
$fontDir = Join-Path $scriptDir "fonts"
$fontPath = Join-Path $fontDir "Sekuya-Regular.ttf"

# Load font from local TTF file
if (Test-Path $fontPath) {
    $fontDirUri = $fontDir.Replace('\', '/') + '/'
    $sekuyaFamily = New-Object System.Windows.Media.FontFamily("file:///$fontDirUri#Sekuya")
} else {
    $sekuyaFamily = New-Object System.Windows.Media.FontFamily("Segoe UI")
}

# Create window
$window = New-Object System.Windows.Window
$window.WindowStyle = [System.Windows.WindowStyle]::None
$window.AllowsTransparency = $true
$window.Width = 520
$window.Height = 260
$window.WindowStartupLocation = [System.Windows.WindowStartupLocation]::CenterScreen
$window.Topmost = $true
$window.ResizeMode = [System.Windows.ResizeMode]::NoResize
$window.ShowInTaskbar = $false

# Dark blue gradient background
$bgBrush = New-Object System.Windows.Media.LinearGradientBrush
$bgBrush.StartPoint = New-Object System.Windows.Point(0, 0)
$bgBrush.EndPoint = New-Object System.Windows.Point(1, 1)
$bgBrush.GradientStops.Add(
    (New-Object System.Windows.Media.GradientStop(
        [System.Windows.Media.ColorConverter]::ConvertFromString("#0a1628"), 0.0))
) | Out-Null
$bgBrush.GradientStops.Add(
    (New-Object System.Windows.Media.GradientStop(
        [System.Windows.Media.ColorConverter]::ConvertFromString("#1a3a5c"), 0.5))
) | Out-Null
$bgBrush.GradientStops.Add(
    (New-Object System.Windows.Media.GradientStop(
        [System.Windows.Media.ColorConverter]::ConvertFromString("#2563eb"), 1.0))
) | Out-Null
$window.Background = $bgBrush

# Main grid
$grid = New-Object System.Windows.Controls.Grid
$window.Content = $grid

# Canvas for layered text
$canvas = New-Object System.Windows.Controls.Canvas
$canvas.HorizontalAlignment = [System.Windows.HorizontalAlignment]::Center
$canvas.VerticalAlignment = [System.Windows.VerticalAlignment]::Center
$canvas.Width = 450
$canvas.Height = 120
$canvas.Margin = New-Object System.Windows.Thickness(0, -20, 0, 0)
$grid.Children.Add($canvas) | Out-Null

# Create formatted text to get geometry
$typeface = New-Object System.Windows.Media.Typeface(
    $sekuyaFamily,
    [System.Windows.FontStyles]::Normal,
    [System.Windows.FontWeights]::Normal,
    [System.Windows.FontStretches]::Normal
)

$formattedText = New-Object System.Windows.Media.FormattedText(
    "Linda",
    [System.Globalization.CultureInfo]::InvariantCulture,
    [System.Windows.FlowDirection]::LeftToRight,
    $typeface,
    100.0,
    [System.Windows.Media.Brushes]::Black
)

# Center the text geometry in the canvas
$textWidth = $formattedText.Width
$textHeight = $formattedText.Height
$offsetX = ($canvas.Width - $textWidth) / 2
$offsetY = ($canvas.Height - $textHeight) / 2 + 10

$geometry = $formattedText.BuildGeometry(
    (New-Object System.Windows.Point($offsetX, $offsetY))
)

# Layer 1: Dark stroke outline (depth on dark background)
$strokePath = New-Object System.Windows.Shapes.Path
$strokePath.Data = $geometry
$strokePath.Stroke = New-Object System.Windows.Media.SolidColorBrush([System.Windows.Media.Color]::FromArgb(120, 0, 0, 0))
$strokePath.StrokeThickness = 8
$strokePath.Fill = [System.Windows.Media.Brushes]::Transparent
$canvas.Children.Add($strokePath) | Out-Null

# Layer 2: Gradient fill (orange to gold)
$gradientBrush = New-Object System.Windows.Media.LinearGradientBrush
$gradientBrush.StartPoint = New-Object System.Windows.Point(0, 0.5)
$gradientBrush.EndPoint = New-Object System.Windows.Point(1, 0.5)
$gradientBrush.GradientStops.Add(
    (New-Object System.Windows.Media.GradientStop(
        [System.Windows.Media.ColorConverter]::ConvertFromString("#FF5E00"), 0.0))
) | Out-Null
$gradientBrush.GradientStops.Add(
    (New-Object System.Windows.Media.GradientStop(
        [System.Windows.Media.ColorConverter]::ConvertFromString("#FFAA00"), 0.5))
) | Out-Null
$gradientBrush.GradientStops.Add(
    (New-Object System.Windows.Media.GradientStop(
        [System.Windows.Media.ColorConverter]::ConvertFromString("#FFE600"), 1.0))
) | Out-Null

$fillPath = New-Object System.Windows.Shapes.Path
$fillPath.Data = $geometry
$fillPath.Fill = $gradientBrush
$fillPath.Stroke = [System.Windows.Media.Brushes]::Transparent
$canvas.Children.Add($fillPath) | Out-Null

# Layer 3: Glow sweep (bright highlight with animated opacity mask)
$glowBrush = New-Object System.Windows.Media.LinearGradientBrush
$glowBrush.StartPoint = New-Object System.Windows.Point(0, 0.5)
$glowBrush.EndPoint = New-Object System.Windows.Point(1, 0.5)
$glowBrush.GradientStops.Add(
    (New-Object System.Windows.Media.GradientStop(
        [System.Windows.Media.ColorConverter]::ConvertFromString("#FFFFFF"), 0.0))
) | Out-Null
$glowBrush.GradientStops.Add(
    (New-Object System.Windows.Media.GradientStop(
        [System.Windows.Media.ColorConverter]::ConvertFromString("#FFFBE6"), 0.5))
) | Out-Null
$glowBrush.GradientStops.Add(
    (New-Object System.Windows.Media.GradientStop(
        [System.Windows.Media.ColorConverter]::ConvertFromString("#FFFFFF"), 1.0))
) | Out-Null

$glowPath = New-Object System.Windows.Shapes.Path
$glowPath.Data = $geometry
$glowPath.Fill = $glowBrush
$glowPath.Stroke = [System.Windows.Media.Brushes]::Transparent

# Opacity mask for sweep effect
$opacityBrush = New-Object System.Windows.Media.LinearGradientBrush
$opacityBrush.StartPoint = New-Object System.Windows.Point(-0.3, 0.5)
$opacityBrush.EndPoint = New-Object System.Windows.Point(0.0, 0.5)
$opacityBrush.GradientStops.Add(
    (New-Object System.Windows.Media.GradientStop([System.Windows.Media.Colors]::Transparent, 0.0))
) | Out-Null
$opacityBrush.GradientStops.Add(
    (New-Object System.Windows.Media.GradientStop([System.Windows.Media.Colors]::Transparent, 0.3))
) | Out-Null
$opacityBrush.GradientStops.Add(
    (New-Object System.Windows.Media.GradientStop([System.Windows.Media.Colors]::White, 0.45))
) | Out-Null
$opacityBrush.GradientStops.Add(
    (New-Object System.Windows.Media.GradientStop([System.Windows.Media.Colors]::White, 0.55))
) | Out-Null
$opacityBrush.GradientStops.Add(
    (New-Object System.Windows.Media.GradientStop([System.Windows.Media.Colors]::Transparent, 0.7))
) | Out-Null
$opacityBrush.GradientStops.Add(
    (New-Object System.Windows.Media.GradientStop([System.Windows.Media.Colors]::Transparent, 1.0))
) | Out-Null

$glowPath.OpacityMask = $opacityBrush
$canvas.Children.Add($glowPath) | Out-Null

# Subtitle — matching landing page style (white, bold, with dark stroke)
$subtitleText = "Land Indicators for Parcel-Driven Insights"

# Create subtitle as geometry for stroke effect (like the landing page)
$subtitleTypeface = New-Object System.Windows.Media.Typeface(
    (New-Object System.Windows.Media.FontFamily("Segoe UI")),
    [System.Windows.FontStyles]::Normal,
    [System.Windows.FontWeights]::Bold,
    [System.Windows.FontStretches]::Normal
)
$subtitleFormatted = New-Object System.Windows.Media.FormattedText(
    $subtitleText,
    [System.Globalization.CultureInfo]::InvariantCulture,
    [System.Windows.FlowDirection]::LeftToRight,
    $subtitleTypeface,
    18.0,
    [System.Windows.Media.Brushes]::White
)

$subtitleCanvas = New-Object System.Windows.Controls.Canvas
$subtitleCanvas.HorizontalAlignment = [System.Windows.HorizontalAlignment]::Center
$subtitleCanvas.VerticalAlignment = [System.Windows.VerticalAlignment]::Center
$subtitleCanvas.Width = $subtitleFormatted.Width + 20
$subtitleCanvas.Height = $subtitleFormatted.Height
$subtitleCanvas.Margin = New-Object System.Windows.Thickness(0, 120, 0, 0)

$subtitleOffsetX = ($subtitleCanvas.Width - $subtitleFormatted.Width) / 2
$subtitleGeometry = $subtitleFormatted.BuildGeometry(
    (New-Object System.Windows.Point($subtitleOffsetX, 0))
)

# Dark stroke behind subtitle
$subtitleStroke = New-Object System.Windows.Shapes.Path
$subtitleStroke.Data = $subtitleGeometry
$subtitleStroke.Stroke = New-Object System.Windows.Media.SolidColorBrush(
    [System.Windows.Media.Color]::FromArgb(200, 0, 0, 0)
)
$subtitleStroke.StrokeThickness = 5
$subtitleStroke.Fill = [System.Windows.Media.Brushes]::Transparent
$subtitleCanvas.Children.Add($subtitleStroke) | Out-Null

# White fill
$subtitleFill = New-Object System.Windows.Shapes.Path
$subtitleFill.Data = $subtitleGeometry
$subtitleFill.Fill = [System.Windows.Media.Brushes]::White
$subtitleFill.Stroke = [System.Windows.Media.Brushes]::Transparent
$subtitleCanvas.Children.Add($subtitleFill) | Out-Null

$grid.Children.Add($subtitleCanvas) | Out-Null

# Start sweep animation
$startPointAnim = New-Object System.Windows.Media.Animation.PointAnimation
$startPointAnim.From = New-Object System.Windows.Point(-0.3, 0.5)
$startPointAnim.To = New-Object System.Windows.Point(1.0, 0.5)
$startPointAnim.Duration = New-Object System.Windows.Duration([TimeSpan]::FromSeconds(2.2))
$startPointAnim.RepeatBehavior = [System.Windows.Media.Animation.RepeatBehavior]::Forever
$startPointAnim.EasingFunction = New-Object System.Windows.Media.Animation.CubicEase
$startPointAnim.EasingFunction.EasingMode = [System.Windows.Media.Animation.EasingMode]::EaseInOut

$endPointAnim = New-Object System.Windows.Media.Animation.PointAnimation
$endPointAnim.From = New-Object System.Windows.Point(0.0, 0.5)
$endPointAnim.To = New-Object System.Windows.Point(1.3, 0.5)
$endPointAnim.Duration = New-Object System.Windows.Duration([TimeSpan]::FromSeconds(2.2))
$endPointAnim.RepeatBehavior = [System.Windows.Media.Animation.RepeatBehavior]::Forever
$endPointAnim.EasingFunction = New-Object System.Windows.Media.Animation.CubicEase
$endPointAnim.EasingFunction.EasingMode = [System.Windows.Media.Animation.EasingMode]::EaseInOut

$window.Add_Loaded({
    $opacityBrush.BeginAnimation(
        [System.Windows.Media.LinearGradientBrush]::StartPointProperty,
        $startPointAnim
    )
    $opacityBrush.BeginAnimation(
        [System.Windows.Media.LinearGradientBrush]::EndPointProperty,
        $endPointAnim
    )
})

# Timer to check for signal file
$startTime = [DateTime]::Now
$timer = New-Object System.Windows.Threading.DispatcherTimer
$timer.Interval = [TimeSpan]::FromMilliseconds(300)
$timer.Add_Tick({
    # Check timeout
    $elapsed = ([DateTime]::Now - $startTime).TotalSeconds
    if ($elapsed -gt $TimeoutSeconds) {
        $timer.Stop()
        $window.Close()
        return
    }

    # Check signal file
    if (Test-Path $SignalFile) {
        $timer.Stop()
        Remove-Item $SignalFile -Force -ErrorAction SilentlyContinue

        # Fade out
        $fadeOut = New-Object System.Windows.Media.Animation.DoubleAnimation
        $fadeOut.From = 1.0
        $fadeOut.To = 0.0
        $fadeOut.Duration = New-Object System.Windows.Duration([TimeSpan]::FromMilliseconds(400))
        $fadeOut.Add_Completed({
            $window.Close()
        }.GetNewClosure())
        $window.BeginAnimation([System.Windows.Window]::OpacityProperty, $fadeOut)
    }
})
$timer.Start()

# Show the window
$window.ShowDialog() | Out-Null
