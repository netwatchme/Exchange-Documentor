###########################################################################

function Global:Format-Object
{Param ($Data , $fieldList, $labels, $sort)

$NewFields = @{}
$Output = @{}
[int]$counter = 0
foreach ($field in $fieldList) {
  if ($counter -eq 0) {
    $NewFields=             @(@{Label=($labels[($counter)]);expression=$fieldlist[$counter]})
  }
  else {
    $NewFields=$NewFields + @(@{Label=($labels[($counter)]);expression=$fieldlist[$counter]})
  }
  $counter++
}

if ($sort -eq $null) {$Output = @($data | select-object @($NewFields))}
else {$Output = @($data | sort-object $sort | select-object @($NewFields))}
@($Output)
}

###########################################################################

Function Global:File-To-Object
{ param ($InFile, $Delim = ":", $NewRecord = "Record #", $Ignore = "Executing")

$Text = Get-Content $InFile
$Text = $Text | %{($_.trim())}
$Record = -1
$Array = @()

foreach ($line in $Text) { 

    if ($line -Like $NewRecord+"*") {
      $Record++
      $Array = $Array + (New-Object PSObject)
      $Array[$Record] | Add-Member NoteProperty "File" $InFile.Name
    }
  if ($line -NotMatch $Ignore) {
    if ($line -match $Delim) {
      $Data = $line | %{($_.split($Delim))}
      # If more than 1 $Delim is found add the entire right side to the array
      if ($Data.count -gt 2) {
        $Value = $line.substring($line.indexof($Delim)+2)
        $Value = $Value.trim()
      }
      else {
        $Value = ($Data[1]).trim()
      }  
        $Prop = $Data[0].trim()
      $Array[$Record] | Add-Member NoteProperty $Prop $Value
    }
  }
}
$Array
}

###########################################################################

Function Global:Create-File
{ param ($Title, $Append, $Table, $OutFile, $ColOrder,
         [string]$AsWhat = "Table", [string]$SubTitle = "", $CRLF = ";;",
         $FileType = "HTML", $Header)

if ($FileType -eq "HTML") {
  $br = "<br>"
  $HTMLSubTitle = "<H3>$SubTitle</H3>"
  $MyReport = ""
  if ($Append -eq 0) { $MyReport = Get-CustomHTML "$Title" }
  $MyReport += Get-CustomHeader "2" "$SubTitle"
  $MyReport += $Table | ConvertTo-Html -fragment -as $AsWhat | %{$_ -replace $CRLF, $br}
  $MyReport += Get-CustomHeaderClose
  if ($Append -eq 0) { $MyReport | out-file -encoding ASCII -filepath $OutFile }
  else { $MyReport | out-file -append -encoding ASCII -filepath $OutFile }
}
elseif ($FileType -eq "Word") {
  if ($Append -eq 0) { 
    WORD\Add-Heading -text $Title -style "Heading 2"
  }
  if ($AsWhat -eq "List") { WORD\Add-TableObjectList -data $Table -caption $SubTitle -style "Medium Grid 2 - Accent 1" -header $Header }
  else { WORD\Add-TableObject -data @($Table) -caption $SubTitle -order $ColOrder }
  WORD\Update-TablesOfContents
}

}

###########################################################################

function Global:Select-FileDialog
{
	param([string]$Title,[string]$Directory,[string]$Filter="All Files (*.*)|*.*")
	[System.Reflection.Assembly]::LoadWithPartialName("System.Windows.Forms") | Out-Null
	$objForm = New-Object System.Windows.Forms.OpenFileDialog
	$objForm.InitialDirectory = $Directory
	$objForm.Filter = $Filter
	$objForm.Title = $Title
	$objForm.ShowHelp = $True
	$Show = $objForm.ShowDialog()
	If ($Show -eq "OK")
	{
		Return $objForm.FileName
	}
	Else
	{
		Write-Error "Operation cancelled by user."
	}
}

###########################################################################

function Global:Select-FolderDialog
{
	param([string]$Title,[string]$Directory,[string]$Filter="All Files (*.*)|*.*")
	[System.Reflection.Assembly]::LoadWithPartialName("System.Windows.Forms") | Out-Null
	$objForm = New-Object System.Windows.Forms.FolderBrowserDialog
    $objForm.SelectedPath = (get-location).path
    $objForm.Description = $Title
	$Show = $objForm.ShowDialog()
	If ($Show -eq "OK")
	{
		Return $objForm.SelectedPath
	}
	Else
	{
		Write-Error "."
	}
}

###########################################################################
###########################################################################
