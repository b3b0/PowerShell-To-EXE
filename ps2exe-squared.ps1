Add-Type -AssemblyName System.Windows.Forms
[System.Windows.Forms.Application]::EnableVisualStyles()

$iconloc = "C:\Users\$env:UserName\AppData\Local\ps2exe-SQUARED\snipe.ico"
$iconfold = "C:\Users\$env:UserName\AppData\Local\ps2exe-SQUARED\ps2exe.ico"

if( -not (Test-Path $iconfold -PathType Container))
{
    New-Item -ItemType "directory" -Path $iconfold
    Invoke-WebRequest http://www.iconj.com/ico/g/w/gwjswchiym.ico -OutFile $iconloc
}

$Form                            = New-Object system.Windows.Forms.Form
$Form.Icon                       = $iconloc
$Form.ClientSize                 = '492,280'
$Form.text                       = "Powershell-To-EXE"
$Form.TopMost                    = $false

$outbox                          = New-Object system.Windows.Forms.TextBox
$outbox.multiline                = $false
$outbox.width                    = 298
$outbox.height                   = 20
$outbox.Anchor                   = 'top,right,left'
$outbox.location                 = New-Object System.Drawing.Point(163,80)
$outbox.Font                     = 'Microsoft Sans Serif,10'

$output                          = New-Object system.Windows.Forms.Button
$output.text                     = "Output (.exe)"
$output.width                    = 102
$output.height                   = 30
$output.location                 = New-Object System.Drawing.Point(47,73)
$output.Font                     = 'Microsoft Sans Serif,10'

$closeButton                     = New-Object system.Windows.Forms.Button
$closeButton.text                = "Close"
$closeButton.width               = 102
$closeButton.height              = 30
$closeButton.Anchor              = 'right,bottom'
$closeButton.location            = New-Object System.Drawing.Point(359,228)
$closeButton.Font                = 'Microsoft Sans Serif,10'

$compile                         = New-Object system.Windows.Forms.Button
$compile.text                    = "Compile"
$compile.width                   = 102
$compile.height                  = 30
$compile.Anchor                  = 'right,bottom'
$compile.location                = New-Object System.Drawing.Point(247,228)
$compile.Font                    = 'Microsoft Sans Serif,10'

$input                           = New-Object system.Windows.Forms.Button
$input.text                      = "Input (.ps1)"
$input.width                     = 102
$input.height                    = 30
$input.location                  = New-Object System.Drawing.Point(46,32)
$input.Font                      = 'Microsoft Sans Serif,10'

$ps2exe                           = New-Object system.Windows.Forms.Button
$ps2exe.text                      = "SET PS2EXE LOCATION"
$ps2exe.width                     = 415
$ps2exe.height                    = 25
$ps2exe.location                  = New-Object System.Drawing.Point(45,0)
$ps2exe.Font                      = 'Microsoft Sans Serif,10'

$inbox                           = New-Object system.Windows.Forms.TextBox
$inbox.multiline                 = $false
$inbox.width                     = 298
$inbox.height                    = 20
$inbox.Anchor                    = 'top,right,left'
$inbox.location                  = New-Object System.Drawing.Point(163,39)
$inbox.Font                      = 'Microsoft Sans Serif,10'

$iconbox                         = New-Object system.Windows.Forms.Button
$iconbox.text                    = "Icon (.ico)"
$iconbox.width                   = 102
$iconbox.height                  = 30
$iconbox.location                = New-Object System.Drawing.Point(49,116)
$iconbox.Font                    = 'Microsoft Sans Serif,10'

$TextBox2                        = New-Object system.Windows.Forms.TextBox
$TextBox2.multiline              = $false
$TextBox2.width                  = 298
$TextBox2.height                 = 20
$TextBox2.Anchor                 = 'top,right,left'
$TextBox2.location               = New-Object System.Drawing.Point(163,122)
$TextBox2.Font                   = 'Microsoft Sans Serif,10'

$pbox                            = New-Object system.Windows.Forms.TextBox
$pbox.multiline                  = $false
$pbox.width                      = 298
$pbox.height                     = 20
$pbox.Anchor                     = 'top,right,left'
$pbox.location                   = New-Object System.Drawing.Point(163,159)
$pbox.Font                       = 'Microsoft Sans Serif,10'

$dbox                            = New-Object system.Windows.Forms.TextBox
$dbox.multiline                  = $false
$dbox.width                      = 298
$dbox.height                     = 20
$dbox.Anchor                     = 'top,right,left'
$dbox.location                   = New-Object System.Drawing.Point(163,193)
$dbox.Font                       = 'Microsoft Sans Serif,10'

$pname                           = New-Object system.Windows.Forms.Label
$pname.text                      = "Product Name:"
$pname.AutoSize                  = $true
$pname.width                     = 25
$pname.height                    = 10
$pname.location                  = New-Object System.Drawing.Point(65,162)
$pname.Font                      = 'Microsoft Sans Serif,10'

$dname                           = New-Object system.Windows.Forms.Label
$dname.text                      = "Version:"
$dname.AutoSize                  = $true
$dname.width                     = 25
$dname.height                    = 10
$dname.location                  = New-Object System.Drawing.Point(84,195)
$dname.Font                      = 'Microsoft Sans Serif,10'

$consoleradio                    = New-Object system.Windows.Forms.RadioButton
$consoleradio.text               = "No console"
$consoleradio.AutoSize           = $true
$consoleradio.width              = 104
$consoleradio.height             = 20
$consoleradio.location           = New-Object System.Drawing.Point(14,244)
$consoleradio.Font               = 'Microsoft Sans Serif,10'

$Form.controls.AddRange(@($outbox,$ps2exe,$output,$closeButton,$compile,$input,$inbox,$iconbox,$TextBox2,$pbox,$dbox,$pname,$dname,$consoleradio))

$input.Add_Click({findinput})
$output.Add_Click({findoutput})
$iconbox.Add_Click({findicon})
$compile.Add_Click({doittoit})
$closeButton.Add_Click({ closeForm })
$ps2exe.Add_Click({findps2})
function closeForm(){$Form.close()}

Function Get-FileName($initialDirectory)
{
    [System.Reflection.Assembly]::LoadWithPartialName("System.windows.forms") | Out-Null
    $OpenFileDialog = New-Object System.Windows.Forms.OpenFileDialog
    $OpenFileDialog.initialDirectory = $initialDirectory
    $OpenFileDialog.filter = "PS1 (*.ps1)| *.ps1"
    $OpenFileDialog.ShowDialog() | Out-Null
    $OpenFileDialog.filename
}
function Get-IconName
{
    [System.Reflection.Assembly]::LoadWithPartialName("System.windows.forms") | Out-Null
    $OpenFileDialog = New-Object System.Windows.Forms.OpenFileDialog
    $OpenFileDialog.initialDirectory = $initialDirectory
    $OpenFileDialog.filter = "ICO (*.ico)| *.ico"
    $OpenFileDialog.ShowDialog() | Out-Null
    $OpenFileDialog.filename
}

Function Give-FileName($initialDirectory)
{
    [System.Reflection.Assembly]::LoadWithPartialName("System.windows.forms") | Out-Null
    $OpenFileDialog = New-Object System.Windows.Forms.SaveFileDialog
    $OpenFileDialog.initialDirectory = $initialDirectory
    $OpenFileDialog.filter = "exe (*.exe)| *.exe"
    $OpenFileDialog.ShowDialog() | Out-Null
    $OpenFileDialog.filename
}
function findinput
{
    $global:infile = Get-FileName
    $inbox.text += $infile
}

function findps2
{
    $global:psin = Get-FileName
}

function findicon
{
    $global:iconfile = Get-IconName
    $TextBox2.text += $iconfile
}

function findoutput
{
    $global:outfile = Give-FileName
    $outbox.text += $outfile
}

function doittoit
{
    $1 = $Global:psin
    $2 = $Global:infile
    $3 = $Global:outfile
    $4 = $Global:iconfile
    $5 = $pbox.Text
    $6 = $dbox.Text

    Write-Host "powershell.exe -file $1 -inputFile $2 -outputFile $3 -noConsole -iconFile $4 -product $5-version $6"

    if ($consoleradio.Checked)
    {
        powershell.exe -file $psin -inputFile $infile -outputFile $outfile -noConsole -iconFile $iconfile -product $pbox.text -version $dbox.text
        Write-Host "Done!"
    }
    if ( -not ($consoleradio.Checked))
    {
        powershell.exe -file $psin -inputFile $infile -outputFile $outfile -iconFile $iconfile -product $pbox.text -version $dbox.text
        Write-Host "Done!"
    }
}

[void]$Form.ShowDialog()
