################################
# Create an Excel instance and create a new workbook & worksheet
function global:EXCEL\Invoke-Excel {
	param ([string] $Template="", $Orientation = 0
	)
	
	$global:objexcel = New-Object -ComObject Excel.Application
	$objExcel.Visible = $True
    $global:objWorkbook = $objExcel.Workbooks.Add()
    $global:objWorksheet = $objWorkbook.Worksheets.Item(1)
	
}

################################
# Create a new worksheet
function global:EXCEL\New-ExcelWorksheet {
	param ([string] $NewWorksheet="New Worksheet"
	)

    $objWorkbook.Worksheets.Add()
    $objWorksheet = $objWorkbook.Worksheets.Item(1)
    $objWorksheet.Name = $NewWorksheet

}

################################
# Create a new Chart
function global:EXCEL\New-ExcelChart {
	param ($xArray, $y1Array,
           $xlChartType=74,
           [string] $Title = "Chart Title",
           [string] $xTitle = "X Axis Title",
           $MaxX, $MinX, $TickX,
           [string] $Series1Name = "Series 1",
           [boolean] $Legend = $false
	)
$xlCategory = 1 
$xlValue = 2 
$xlSeriesAxis = 3 

$count = 1
ForEach ($xValue in $xArray) {
  $objWorksheet.Cells.Item($count,1) = $xValue
  $objWorksheet.Cells.Item($count,2) = $y1Array[$count-1]
  $count ++
}

$objRange = $objWorksheet.range("a1:b"+$xArray.count)

$xlChartType=74
$xlChartType=51
$objChart = $objWorksheet.shapes.addChart().chart
$objChart.chartType = $xlChartType
$objChart.setSourceData($objRange)

$objChart.seriesCollection(1).name = $Series1Name
$objChart.HasLegend = $Legend

$objChart.HasTitle = $true
$objChart.ChartTitle.Text = $Title

#Format the X Axis
$objChart.Axes($xlCategory).HasTitle = $true
$objChart.Axes($xlCategory).AxisTitle.Text = $xTitle
$objChart.Axes($xlCategory).MaximumScale = $MaxX
$objChart.Axes($xlCategory).MinimumScale = $MinX
$objChart.Axes($xlCategory).MajorUnit = $TickX

Format the Y Axis
$objChart.Axes($xlValue).MajorUnitIsAuto = $false
}

################################
# Close Excel
function global:EXCEL\Close-Excel {

[System.Runtime.Interopservices.Marshal]::ReleaseComObject($objWorksheet)
Remove-Variable objWorksheet
[System.Runtime.Interopservices.Marshal]::ReleaseComObject($objWorkbook)
Remove-Variable objWorkbook
[System.Runtime.Interopservices.Marshal]::ReleaseComObject($objExcel)
Remove-Variable objExcel
}

