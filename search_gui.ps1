<# This form was created using POSHGUI.com  a free online gui designer for PowerShell
.NAME
    Smart search engine for local Windows drives
.SYNOPSIS
    Let's the user find files by searching with filename or any keyword that should exist in the contents of the file
#>

# Initialize powershell GUI
Add-Type -AssemblyName System.Windows.Forms
[System.Windows.Forms.Application]::EnableVisualStyles()

#Create a new form
$main_form = New-Object System.Windows.Forms.Form
$main_form.Text = "ITAS G: Drive resources"
$main_form.Width = 800
$main_form.Height = 600
$main_form.AutoSize = $true

# Title
$title = New-Object System.Windows.Forms.Label
$title.text = "Opening ITAS resources on G drive"
$title.AutoSize = $true
$title.Location = New-Object System.Drawing.Point(20,20)
$title.Font = "Microsoft Sans Serif, 13"

# Description
$description = New-Object System.Windows.Forms.Label
$description.Text = "Search for any document by entering a filename or any keyword that may exist in the document"
$description.AutoSize = $true
# $description.Width = 450
# $description.Height = 50
$description.Location = New-Object System.Drawing.Point(22,50)
$description.Font = "Microsoft Sans Serif, 10"


## Add search box and results table

# Search box
$search = New-Object System.Windows.Forms.TextBox
$search.Location = New-Object System.Drawing.Point(22, 100)
$search.Size = New-Object System.Drawing.Size(260,20)
#$search.AutoSize = $true

# Results table
$results = New-Object System.Windows.Forms.TextBox
$results.Multiline = $true
$results.Location = New-Object System.Drawing.Point(22, 130)
$results.Size = New-Object System.Drawing.Size(750, 200)
$results.ScrollBars = "Vertical"

## Add buttons

# Enter
$press_enter = New-Object System.Windows.Forms.Button
$press_enter.Text = "Enter"
$press_enter.AutoSize = $true
$press_enter.Location = New-Object System.Drawing.Point(300,95)
$press_enter.Font = "Microsoft Sans Serif, 10"

# Add close button
$close_button = New-Object System.Windows.Forms.Button
$close_button.Text = "Close"
$close_button.AutoSize = $true
$close_button.Location = New-Object System.Drawing.Point(370,400)
$close_button.Font = "Microsoft Sans Serif, 10"

# Add elements to the form
$main_form.Controls.AddRange(@($title, $description, $press_enter, $search, $results, $close_button))


function closeForm()
{
    $main_form.close()
}

function enter_button()
{
    $results.Text += "`r`n" + "testing display: " + $search.Text
}

$press_enter.Add_Click({ enter_button })
$close_button.Add_Click({ closeForm })

# Display form
[void]$main_form.ShowDialog()
