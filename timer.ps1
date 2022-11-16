function Generate-GUI {
    Add-Type -AssemblyName System.Windows.Forms
    Add-Type -AssemblyName System.Drawing

    [System.Windows.Forms.Application]::EnableVisualStyles()

    $ShutdownTimerGUI = New-Object system.Windows.Forms.Form
    $ShutdownTimerGUI.FormBorderStyle = 'Fixed3D'
    $ShutdownTimerGUI.MaximizeBox = $false
    $ShutdownTimerGUI.ClientSize = '500,300'
    $ShutdownTimerGUI.text = "Shutdown Timer"
    $ShutdownTimerGUI.BackColor = "#ffffff"

    $Title = New-Object system.Windows.Forms.Label
    $Title.text = "Create a timer"
    $Title.AutoSize = $true
    $Title.location = New-Object System.Drawing.Point(20,30)
    $Title.Font = 'Arial,14'
    $ShutdownTimerGUI.Controls.Add($Title)

    $TimeInputBoxLabel = New-Object system.Windows.Forms.Label
    $TimeInputBoxLabel.text = "Enter time (minutes):"
    $TimeInputBoxLabel.AutoSize = $true
    $TimeInputBoxLabel.Enabled = $false
    $TimeInputBoxLabel.location = New-Object System.Drawing.Point(20,105)
    $TimeInputBoxLabel.Font = 'Arial,10'
    $ShutdownTimerGUI.Controls.Add($TimeInputBoxLabel)

    $TimeInputBox = New-Object System.Windows.Forms.NumericUpDown
    $TimeInputBox.AutoSize = $true
    $TimeInputBox.Value = 60
    $TimeInputBox.Minimum = 1
    $TimeInputBox.Enabled = $false
    $TimeInputBox.Maximum = 5256000
    $TimeInputBox.Location = New-Object System.Drawing.Point(20,130)
    $TimeInputBox.Font = 'Arial,12'
    $ShutdownTimerGUI.Controls.Add($TimeInputBox)

    $ActionSelectorLabel = New-Object system.Windows.Forms.Label
    $ActionSelectorLabel.text = "Select an action:"
    $ActionSelectorLabel.AutoSize = $true
    $ActionSelectorLabel.Enabled = $false
    $ActionSelectorLabel.location = New-Object System.Drawing.Point(20,185)
    $ActionSelectorLabel.Font = 'Arial,10'
    $ShutdownTimerGUI.Controls.Add($ActionSelectorLabel)

    $ActionSelector = New-Object system.Windows.Forms.ComboBox
    $ActionSelector.DropDownStyle = [System.Windows.Forms.ComboBoxStyle]::DropDownList;
    $ActionSelector.width = 170
    $ActionSelector.autosize  = $true
    @('Hibernate','Shut Down','Restart') | ForEach-Object {[void] $ActionSelector.Items.Add($_)}
    $ActionSelector.SelectedIndex = 1
    $ActionSelector.Enabled = $false
    $ActionSelector.location = New-Object System.Drawing.Point(20,210)
    $ActionSelector.Font = 'Arial,12'
    $ShutdownTimerGUI.Controls.Add($ActionSelector)

    $SetTimerBTN = New-Object system.Windows.Forms.Button
    $SetTimerBTN.text = "Set Timer"
    $SetTimerBTN.width = 90
    $SetTimerBTN.autosize  = $true
    $SetTimerBTN.Enabled = $false
    $SetTimerBTN.location = New-Object System.Drawing.Point(290,250)
    $SetTimerBTN.Font = 'Arial,10'
    $SetTimerBTN.ForeColor = "#00000"
    $SetTimerBTN.Add_Click({Set-Timer})
    $ShutdownTimerGUI.Controls.Add($SetTimerBTN)

    $AbortBTN = New-Object system.Windows.Forms.Button
    $AbortBTN.text = "Abort"
    $AbortBTN.width = 90
    $AbortBTN.autosize  = $true
    $AbortBTN.Enabled = $false
    $AbortBTN.location = New-Object System.Drawing.Point(390,250)
    $AbortBTN.Font = 'Arial,10'
    $AbortBTN.ForeColor = "#00000"
    $AbortBTN.Add_Click({Stop-Timer})
    $ShutdownTimerGUI.Controls.Add($AbortBTN)

    Initialize-GUI

    [void]$ShutdownTimerGUI.ShowDialog()
}

function Initialize-GUI {
    shutdown /s /t 999999 /c " "
    if ($?) {
        shutdown /a
        echo No shutdown is pending
        $TimeInputBoxLabel.Enabled = $true
        $TimeInputBox.Enabled = $true
        $ActionSelectorLabel.Enabled = $true
        $ActionSelector.Enabled = $true
        $SetTimerBTN.Enabled = $true
    } else {
        echo Shutdown is pending
        $AbortBTN.Enabled = $true
    }
}
function Set-Timer {
    $args = [ordered]@{ 0 = "/h"; 1 = "/s"; 2 = "/r"}
    $selectedIndex = $ActionSelector.SelectedIndex
    $seconds = $TimeInputBox.Value * 60
    shutdown $args.$selectedIndex /t $seconds
    $TimeInputBoxLabel.Enabled = $false
    $TimeInputBox.Enabled = $false
    $ActionSelectorLabel.Enabled = $false
    $ActionSelector.Enabled = $false
    $SetTimerBTN.Enabled = $false
    $AbortBTN.Enabled = $true
}

function Stop-Timer {
        shutdown /a
        $AbortBTN.Enabled = $false
        $TimeInputBoxLabel.Enabled = $true
        $TimeInputBox.Enabled = $true
        $ActionSelectorLabel.Enabled = $true
        $ActionSelector.Enabled = $true
        $SetTimerBTN.Enabled = $true
}

Generate-GUI
