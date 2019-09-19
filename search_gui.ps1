<# This form was created using POSHGUI.com  a free online gui designer for PowerShell
.NAME
    Smart search engine for local Windows drives
.SYNOPSIS
    Let's the user find files by searching with filename or any keyword that should exist in the contents of the file
#>

#------------[Initialisation]------------

# Initialize powershell GUI
Import-Module C:\Users\sxa401\Powershell\Modules\folderselect.psm1
Add-Type -AssemblyName System.Windows.Forms

[System.Windows.Forms.Application]::EnableVisualStyles()


#---------------[Form]-------------------

#Create a new form
$main_form = New-Object System.Windows.Forms.Form

# Define form properties
$main_form.Text = "Smart Search"
$main_form.Width = 800
$main_form.Height = 600
$main_form.AutoSize = $true
$main_form.KeyPreview = $true


# Title
$title = New-Object System.Windows.Forms.Label
$title.text = "Find files in your PC using smart search"
$title.AutoSize = $true
$title.Location = New-Object System.Drawing.Point(20,20)
$title.Font = "Microsoft Sans Serif, 13"

# Description
$description = New-Object System.Windows.Forms.Label
$description.Text = "Search for any document by entering a filename or any keyword that may exist in the document"
$description.AutoSize = $true
$description.Location = New-Object System.Drawing.Point(22,50)
$description.Font = "Microsoft Sans Serif, 10"


## Add search box and results table

# Search box
$search = New-Object System.Windows.Forms.TextBox
$search.Location = New-Object System.Drawing.Point(400, 100)
$search.Size = New-Object System.Drawing.Size(260,50)
#$search.AutoSize = $true

# Results table
$results = New-Object System.Windows.Forms.TextBox
$results.Multiline = $true
$results.Location = New-Object System.Drawing.Point(22, 130)
$results.Size = New-Object System.Drawing.Size(750, 300)
$results.ScrollBars = "Vertical"


## Add buttons

# Enter button
$press_enter = New-Object System.Windows.Forms.Button
$press_enter.Text = "Enter"
$press_enter.AutoSize = $true
$press_enter.Location = New-Object System.Drawing.Point(700,95)
$press_enter.Font = "Microsoft Sans Serif, 10"

# Close button
$close_button = New-Object System.Windows.Forms.Button
$close_button.Text = "Close"
$close_button.AutoSize = $true
$close_button.Location = New-Object System.Drawing.Point(350,500)
$close_button.Font = "Microsoft Sans Serif, 10"

# Select folder button
$select_button = New-Object System.Windows.Forms.Button
$select_button.Text = "Select folder"
$select_button.AutoSize = $true
$select_button.Location = New-Object System.Drawing.Point(22,95)
$select_button.Font = "Microsoft Sans Serif, 10"

# Add elements to the form
$main_form.Controls.AddRange(@($title, $description, $press_enter, $close_button, $select_button, $search, $results))


#------------[Functions]------------

function current_dir ($input_folder)
{
    cd $input_folder
    $results.Text += "Current directory is: " + $PWD + "``n"
}

function invoke_dir
{
    $selectFolder = New-Object System.Windows.Forms.FolderBrowserDialog
    $selectFolder.Description = "Select a folder"
    #$selectFolder.RootFolder = "\\OMEGA.DCE-EIR.NET\natdfs\CRA\HQ\ITB\ITB_H19\GV3\ITB\SOLUTIONS\SAID"

    if ($selectFolder.ShowDialog() -eq "OK")
    {
        $cur_folder += $selectFolder.SelectedPath
    }
    
    #cd $cur_folder
    current_dir($cur_folder)
    return $cur_folder
    
}

function search()
{
    
    $results.Text += "`r`n" + $search.Text
}

function closeForm()
{
    $main_form.Close()
}


#------------[Logic]------------

current_dir($HOME)
$select_button.Add_Click( {invoke_dir} )
$press_enter.Add_Click( {search} )
$close_button.Add_Click( {closeForm} )
#invoke_dir


if ($form_openclose_event -eq [System.Windows.Forms.DialogResult]::Cancel)
{
    Write-Output 'User pressed close to exit the form.'
}

#------------[Show form]------------

# Display form
$main_form.TopMost = $true
$form_openclose_event = $main_form.ShowDialog()
