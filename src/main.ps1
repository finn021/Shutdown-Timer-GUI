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
    $IconBase64 = 'iVBORw0KGgoAAAANSUhEUgAAADAAAAAwCAYAAABXAvmHAAAAAXNSR0IArs4c6QAAA1VJREFUaEPtmP2RTUEQxc9GYEXARrBEgAjYCKwIEAEiQARsBIgAESwRIAJEQP22pqva1J2Zno/3x1Ovq7bevnfv9PTpPv0xc6Q9l6M9t18rAfzpdMaSvZcoSYYfAHRG8Or1lREY2X96zQHAtAsnFayMwE1JdyQ9kHQs6Vb6NBM/Sfolic8Pkr5P2r4sBx5KepIM7rEJAM8lXWwswgEIgKsyE4G7kp5J4nNGAPIoRQY9GP8xKbzXAjEK4I2k88zq38mI94keUMULQKEZFOP/a9nzV5JeJOOhH/JF0u2ad3oB4J13mdcxHCpgQI9AO9blQLwOIvN2FQALrXkHva+TEU2uFoxAJyAebzxvGs+angjAS8/30AbBkEBHaGlCXpxE1kYB5JyHl/CzJvD9RnrhR6Bs4hxLXosuNKtKBECuOOp5qEGVQkhOvrckj8SZJIpCUSIAPHWo2Xn1KSkfAYAukpbegjSp1AJAyaPqIFQbaBFN2FEAJDaGW3WqRrwFgFrOeNBDA4vIKADW+7XVXlADgCd+On60wOZUmgGALn9AoiJtzk41o3xCMXxBpx6ZBUDy3k8bPi01yhoAryBaeTzAWQDegZ9LM1cNgOc/Q1U+27SiMQvAl+8hAJduRC5ysIJiFgAV71urnNYi4JOoN4HzShJtZLk/mjb81wCov6fJJZHZJ/ceFODPOmrvEZKpFxojX0snvl0mcSvJW8+nk9jPJMU63LJi4jmT6Mu0vjiD7bKRTdh+tTTUh3pGiesdg9ys8fkYU9y7VR69F0ZL4QgY30OqY0wLgE8kxmgaWnScHjGcNXifBmZ3Q9UpoAUAhX6kICKcknYpnD9scCyOEGZABIBv6azbJZU8ddirOcJEAORjAd9HptNW1PLzcKh0RwGwue8LBoporBAO//7QHz579wAgqcgHGy+sVuOp3jHBQENPmpU/LDE2UDxCxaIHgFUIrhDt1oDf2IjfuKULbZoqDLdxdFurNugKe74nibco4tu8f84ACNXs0gtvIhY1BjS47q8nbX2I87kxvRHw6wk/nrdz62gu0KhwyBANZwCYwfAVA7auzEug7CoeB/QeVf/RuQKAV2h3/0YRf8/Pe1ALg6vXhT2hXA2gZ+8l7x4ALHHjhJK9j8BfYQO4MbXNqioAAAAASUVORK5CYII='
    $IconBytes = [Convert]::FromBase64String($IconBase64)
    $Stream = New-Object IO.MemoryStream($IconBytes, 0, $IconBytes.Length)
    $Stream.Write($IconBytes, 0, $IconBytes.Length)
    $ShutdownTimerGUI.Icon = [System.Drawing.Icon]::FromHandle((New-Object System.Drawing.Bitmap -Argument $Stream).GetHIcon())



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
