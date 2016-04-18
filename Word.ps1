#
# Word Automation Library, v1.0 for PowerShell 1.0
# Dennis Damen, Login Consultants
#

function global:WORD\Invoke-Word {
	param ([string] $Template, $Orientation = 0
	)
	
	$global:word = New-Object -ComObject Word.Application
	$global:doc = $word.Documents.Add($Template)
	$global:Missing = [System.Reflection.Missing]::Value
	
	$word.Visible=$True
    $doc.pagesetup.orientation = $Orientation
	
}

function global:WORD\Add-Heading {
	param (
		[string] $Text,
		[string] $Style = "Heading 1"
	)
	
	$Paragraph = $doc.Content.Paragraphs.Add($Missing)
	$Paragraph.Range.Text = $Text
	if ($Style -ne "") {$Paragraph.Range.Style = $Style}
	$Paragraph.Range.InsertParagraphAfter()
	
}

function global:WORD\Add-Paragraph {
	param (
		[string] $Text,
		[string] $Style = "Normal"
	)
	
	$Paragraph = $doc.Content.Paragraphs.Add($Missing)
	$Paragraph.Range.Text = $Text
	$Paragraph.Range.Style = $Style
	$Paragraph.Range.InsertParagraphAfter()

}

function global:WORD\Add-TableObject {
	param (
		$Data,
		[string] $Caption,
        $Order,
		[string] $Style = "Light List - Accent 1"
	)
	
    $CRLF = ";;"
    $br = "`r`n"
    $Rows = $Data.count + 1
    $Headers = ($Data | gm -membertype noteproperty)
    $Columns = $Headers.count
    if ($Order -eq $null) { [array]$Order = 0..($columns-1) }

    
	$Paragraph = $doc.Content.Paragraphs.Add($Missing)
	$Range = $Paragraph.Range
	$Table = $doc.Tables.Add($Range, $Rows, $Columns, $Missing, $Missing)

#format headers
	for([int] $y = 0;$y -lt $Columns;$y++)
	{
		$Table.Cell(1, $y + 1).Range.Text = $Headers[$order[$y]-1].Name
	}

#format body
	for([int] $x = 1;$x -lt $Rows;$x++)
	{
		for([int] $y = 0;$y -lt $Columns;$y++)
		{
            $rawcelldata = $Data[$x-1].($Headers[$order[$y]-1].Name)
            $celldata = $rawcelldata | %{$_ -replace $CRLF, $br}
			$Table.Cell($x + 1, $y + 1).Range.Text = $celldata
		}
	}
	$Table.Range.Style = $Style
	
	if ($Caption -ne "") { $Table.Range.InsertCaption("Table"," - " + $Caption , "", 1) }

	$Table.Rows.AllowBreakAcrossPages = 0
	$HeaderRow = $Table.Rows | where {$_.index -eq 1}
	$HeaderRow.HeadingFormat = -1
	
    $Caption
    if ($Caption -eq "XenDesktop Desktop Groups Peak Hour Definitions" -or $Caption -eq "XenDesktop Desktop Groups Pool Size Settings") {
      $Table.Columns.PreferredWidth = $Word.InchesToPoints(.25)
      $Table.Columns.Item(1).PreferredWidth = $Word.InchesToPoints(2)
    }
    
        
	$Paragraph.Range.InsertParagraphAfter()
}

function global:WORD\Add-TableObjectList {
	param (
		$Data,
		[string] $Caption,
		[string] $Style = "Light List - Accent 1",
        [string] $Header
	)
	
    $CRLF = ";;"
    $br = "`r`n"
    $Data = @($Data)
    #$Headers = ($Data | gm -membertype noteproperty)
    $Headers = $Data | % { $_ | gm -membertype noteproperty}
    $Headers = $Headers | sort name | select name -unique
    $StartRow = 1
    if ($header -ne "") { $StartRow = 2 }
    $Rows = $Headers.count 
    $Columns = @($Data).count + 1
    
	$Paragraph = $doc.Content.Paragraphs.Add($Missing)
	$Range = $Paragraph.Range
	$Table = $doc.Tables.Add($Range, $Rows+$StartRow-1, $Columns, $Missing, $Missing)

#format the header row
  if ($header -ne $null) {
    $Table.Cell(1,1).Range.Text = $Header
    #cycle through the columns
    for([int] $x = 0;$x -lt ($Columns-1); $x++)
    {
      $Table.Cell(1, $x+2).Range.Text = $Data[$x].($Header)
    }
  }
#format body
#cycle through the rows
    for([int] $y = 0;$y -lt $Rows;$y++)
	{
#        $rawcelldata = $Data[$x-1].($Headers[$order[$y]-1].Name)
#        $celldata = $rawcelldata | %{$_ -replace $CRLF, $br}
        $Table.Cell($y+$StartRow, 1).Range.Text = $Headers[$y].Name
        
        #cycle through the columns
        for([int] $x = 0;$x -lt ($Columns-1); $x++)
        {
          $Table.Cell($y+$StartRow, $x+2).Range.Text = $Data[$x].($Headers[$y].name)
        }
     }
	$Table.Range.Style = $Style
	
	if ($Caption -ne "") { $Table.Range.InsertCaption("Table"," - " + $Caption , "", 1) }

	$Table.Rows.AllowBreakAcrossPages = 0
    if ($header -ne $null) {
      $HeaderRow = $Table.Rows | where {$_.index -eq 1}
      $HeaderRow.HeadingFormat = -1
	}
    
	$Paragraph.Range.InsertParagraphAfter()
}

function global:WORD\Add-TableArray {
	param (
		[int] $Columns,
		[int] $Rows,
		[String[]] $Data,
		[string] $Caption,
		[string] $Style = "Light List - Accent 1"
	)
	
	# Data array layout:
	#
	# row: a,b,c,d,e
	# row: 1,2,3,4,5
	#
	# Array: a,b,c,d,e,1,2,3,4,5
	
	$Paragraph = $doc.Content.Paragraphs.Add($Missing)
	$Range = $Paragraph.Range
	$Table = $doc.Tables.Add($Range, $Rows, $Columns, $Missing,$Missing)
	
	for([int] $x = 0;$x -lt $Rows;$x++)
	{
		for([int] $y = 0;$y -lt $Columns;$y++)
		{
			$index = ($x * $Columns) + $y 
			$Table.Cell($x + 1, $y + 1).Range.Text = $Data[$index]
		}
	}
	$Table.Range.Style = $Style
	
	if ($Caption -ne "")
	{
		$Table.Range.InsertCaption("Table"," - " + $Caption , "", 1)
	}
	
	$Paragraph.Range.InsertParagraphAfter()
}

function global:WORD\Add-TableOfContents {
	param (
		[string] $Title = "Table of Contents",
		[string] $HeadingStyle = "TOC Heading",
		[string] $Style = "Normal"
	)
	
	WORD\Add-Heading -Text $Title -style $HeadingStyle
	
	$Paragraph = $doc.Content.Paragraphs.Add($Missing)
	$Range = $Paragraph.Range
	$TOC = $doc.TablesOfContents.Add($Range,$Missing,$Missing,$Missing,$Missing,$Missing,$Missing,$Missing,$Missing,$Missing,$Missing,$Missing)
	$Paragraph.Range.InsertParagraphAfter()
	
}

function global:WORD\Update-TablesOfContents {

	foreach ($TOC in $doc.TablesOfContents)
	{
		$TOC.Update()
	}

}

function global:WORD\Add-PageBreak {
	
	$Paragraph = $doc.Content.Paragraphs.Add($Missing)
	$Paragraph.Range.InsertBreak()
	
}

function global:WORD\Add-TextBox {

	param (
		[string] $Text,
		[string] $Style = "No Spacing"
	)

	$Paragraph = $doc.Content.Paragraphs.Add($Missing)
	$Paragraph.Range.Text = $Text
	$Paragraph.Range.Style = $Style
	
	$Frame = $doc.Frames.Add($doc.Range($Paragraph.Range.Start, $Paragraph.Range.End - 1))
	
	$Paragraph.Range.InsertParagraphAfter()
	
}