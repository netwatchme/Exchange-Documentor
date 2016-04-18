################################
# Process Exchange 2010
Function Global:Docs-Exch-ToTXT {

$ID = 234332
$Increment = 2
$PctComplete = 0

$PctComplete += $Increment
write-progress -ID $ID -activity "Creating Exchange Documentation" -status "AcctAdministrator" -percentcomplete $PctComplete
$GetObj = Get-AcctAdministrator| sort-object account 
$TXTFile = "AcctAdministrator.txt"
$GetObj | FL * | out-file $TXTFile -width 400

write-progress -ID $ID -activity "Creating Exchange Documentation" -Status "Done" -completed

}

################################
# Process Accepted Domains
Function Global:Docs-Ex-AcceptedDomain {
$NewRecord = "RunspaceId"
$Source = "Get-AcceptedDomain.xml"
$Delim = " : "
Remove-Variable GetObj
$GetObj = @(Import-CLIXML $Source)

$ID = 133222
$Field = @("DomainName","DomainType","Default","AddressBookEnabled")
$Label = @("Name","Type","Default","Address Book")
$HTMLTitle = "Accepted Domains"
$HTMLFile = "AcceptedDomains.html"
$HTMLSubTitle = $HTMLTitle
[int]$AppendFile = 0
$Sort = "Name"
$ColOrder = (3,4,2,1)
$FormattedTable = Format-Object $GetObj $Field $Label $Sort
write-progress -ID $ID -activity $HTMLTitle -status $HTMLSubTitle -percentcomplete 0
Create-File -title $HTMLTitle -Subtitle $HTMLSubTitle -append $AppendFile -table $FormattedTable -outfile $HTMLFile -colorder $ColOrder -filetype $format

write-progress -ID $ID -activity $HTMLTitle -status $HTMLSubTitle -completed
}

################################
# Process Exchange Remote Domains
Function Global:Docs-Ex-RemoteDomain {
$NewRecord = "RunspaceId"
$Source = "Get-RemoteDomain.xml"
$Delim = " : "
Remove-Variable GetObj
$GetObj = @(Import-CLIXML $Source)

$ID = 144222
$Field = @("domainname","AllowedOOFType","AutoReplyEnabled","AutoForwardEnabled","DeliveryReportEnabled","NDREnabled","DisplaySenderName")
$Label = @("Domain Name","OOF Type","Auto Reply","Auto Forward","Delivery","NDR","Display Sender Name")
$HTMLTitle = "Remote Domains"
$HTMLFile = "RemoteDomains.html"
$HTMLSubTitle = $HTMLTitle
[int]$AppendFile = 0
$Sort = "Name"
$ColOrder = (5,7,2,1,3,6,4)
$FormattedTable = Format-Object $GetObj $Field $Label $Sort
write-progress -ID $ID -activity $HTMLTitle -status $HTMLSubTitle -percentcomplete 0
Create-File -title $HTMLTitle -Subtitle $HTMLSubTitle -append $AppendFile -table $FormattedTable -outfile $HTMLFile -colorder $ColOrder -filetype $format

write-progress -ID $ID -activity $HTMLTitle -status $HTMLSubTitle -completed
}

################################
# Process Exchange Mailbox Databases
Function Global:Docs-Ex-MBXServers {
$NewRecord = "RunspaceId"
$Source = "Get-MailboxServer.xml"
$Delim = " : "
Remove-Variable GetObj
$GetObj = @(Import-CLIXML $Source)

$ID = 133222
$Field = @("name","DatabaseAvailabilityGroup","ExchangeVersion","RedundantMachines")
$Label = @("Name","DAG","Version","Clustered Servers")
$HTMLTitle = "Mailbox Servers"
$HTMLFile = "MailboxServers.html"
$HTMLSubTitle = $HTMLTitle
[int]$AppendFile = 0
$Sort = "Name"
$ColOrder = (3,4,2,1)
$FormattedTable = Format-Object $GetObj $Field $Label $Sort
write-progress -ID $ID -activity $HTMLTitle -status $HTMLSubTitle -percentcomplete 0
Create-File -title $HTMLTitle -Subtitle $HTMLSubTitle -append $AppendFile -table $FormattedTable -outfile $HTMLFile -colorder $ColOrder -filetype $format

write-progress -ID $ID -activity $HTMLTitle -status $HTMLSubTitle -completed
}

################################
# Process Exchange Mailbox Databases
Function Global:Docs-Ex-DAG {
$NewRecord = "RunspaceId"
$Source = "Get-DatabaseAvailabilityGroup.xml"
$Delim = " : "
Remove-Variable GetObj
$GetObj = @(Import-CLIXML $Source)

$ID = 166222
$Field = @("name","Servers","WitnessServer","DatabaseAvailabilityGroupIpAddresses")
$Label = @("Name","Servers","Witness","DAG IP Address")
$HTMLTitle = "Database Availability Group"
$HTMLFile = "DatabaseAvailabilityGroup.html"
$HTMLSubTitle = $HTMLTitle
[int]$AppendFile = 0
$Sort = "Name"
$ColOrder = (2,3,4,1)
$FormattedTable = Format-Object $GetObj $Field $Label $Sort
write-progress -ID $ID -activity $HTMLTitle -status $HTMLSubTitle -percentcomplete 0
Create-File -title $HTMLTitle -Subtitle $HTMLSubTitle -append $AppendFile -table $FormattedTable -outfile $HTMLFile -colorder $ColOrder -filetype $format

$Source = "Get-DatabaseAvailabilityGroupNetwork.xml"
$Delim = " : "
Remove-Variable GetObj
$GetObj = @(Import-CLIXML $Source)

$ID = 166222
$Field = @("Identity","Interfaces","Subnets","MapiAccessEnabled","ReplicationEnabled")
$Label = @("Name","Interfaces","Subnets","MAPI","Replication")
$HTMLTitle = "Database Availability Group"
$HTMLFile = "DatabaseAvailabilityGroup.html"
$HTMLSubTitle = $HTMLTitle + " - Network"
[int]$AppendFile = 1
$Sort = "Name"
$ColOrder = (3,1,5,2,4)
$FormattedTable = Format-Object $GetObj $Field $Label $Sort
write-progress -ID $ID -activity $HTMLTitle -status $HTMLSubTitle -percentcomplete 0
Create-File -title $HTMLTitle -Subtitle $HTMLSubTitle -append $AppendFile -table $FormattedTable -outfile $HTMLFile -colorder $ColOrder -filetype $format

write-progress -ID $ID -activity $HTMLTitle -status $HTMLSubTitle -completed
}

################################
# Process Exchange Mailbox Databases
Function Global:Docs-Ex-CAServers {
$NewRecord = "RunspaceId"
$Source = "Get-ClientAccessServer.xml"
$Delim = " : "
Remove-Variable GetObj
$GetObj = @(Import-CLIXML $Source)

$ID = 144222
$Field = @("name","AutoDiscoverSiteScope","ExchangeVersion")
$Label = @("Name","AD Site","Version")
$HTMLTitle = "Client Access Servers"
$HTMLFile = "ClientAccessServers.html"
$HTMLSubTitle = $HTMLTitle
[int]$AppendFile = 0
$Sort = "Name"
$ColOrder = (2,3,1)
$FormattedTable = Format-Object $GetObj $Field $Label $Sort
write-progress -ID $ID -activity $HTMLTitle -status $HTMLSubTitle -percentcomplete 0
Create-File -title $HTMLTitle -Subtitle $HTMLSubTitle -append $AppendFile -table $FormattedTable -outfile $HTMLFile -colorder $ColOrder -filetype $format

write-progress -ID $ID -activity $HTMLTitle -status $HTMLSubTitle -completed
}

################################
# Process Exchange CAS Array
Function Global:Docs-Ex-CASArray {
$NewRecord = "RunspaceId"
$Source = "Get-ClientAccessArray.xml"
$Delim = " : "
Remove-Variable GetObj
$GetObj = @(Import-CLIXML $Source)
$GetObj | ForEach-Object {
  # Format attributes
  $_.Members = ($_.Members).Replace("{","")
  $_.Members = ($_.Members).Replace("}","")
  $_.Members = ($_.Members).Replace(", ","`n")
}

$ID = 166222
$Field = @("name","Fqdn","Members","SiteName")
$Label = @("Name","FQDN","Members","AD Site")
$HTMLTitle = "CAS Array"
$HTMLFile = "CASArray.html"
$HTMLSubTitle = $HTMLTitle
[int]$AppendFile = 0
$Sort = "Name"
$ColOrder = (4,2,3,1)
$FormattedTable = Format-Object $GetObj $Field $Label $Sort
write-progress -ID $ID -activity $HTMLTitle -status $HTMLSubTitle -percentcomplete 0
Create-File -title $HTMLTitle -Subtitle $HTMLSubTitle -append $AppendFile -table $FormattedTable -outfile $HTMLFile -colorder $ColOrder -filetype $format

write-progress -ID $ID -activity $HTMLTitle -status $HTMLSubTitle -completed
}

################################
# Process Exchange Mailbox Databases
Function Global:Docs-Ex-HTServers {
$NewRecord = "RunspaceId"
$Source = "Get-TransportServer.xml"
$Delim = " : "
Remove-Variable GetObj
$GetObj = @(Import-CLIXML $Source)

$ID = 144222
$Field = @("name","ExchangeVersion","AntispamAgentsEnabled")
$Label = @("Name","Version","Anti-SPAM Enabled")
$HTMLTitle = "Hub Transport Servers"
$HTMLFile = "HubTransportServers.html"
$HTMLSubTitle = $HTMLTitle
[int]$AppendFile = 0
$Sort = "Name"
$ColOrder = (2,3,1)
$FormattedTable = Format-Object $GetObj $Field $Label $Sort
write-progress -ID $ID -activity $HTMLTitle -status $HTMLSubTitle -percentcomplete 0
Create-File -title $HTMLTitle -Subtitle $HTMLSubTitle -append $AppendFile -table $FormattedTable -outfile $HTMLFile -colorder $ColOrder -filetype $format

write-progress -ID $ID -activity $HTMLTitle -status $HTMLSubTitle -completed
}

################################
# Process Exchange Mailbox Databases
Function Global:Docs-Ex-StorageGroups {
$NewRecord = "RunspaceId"
$Source = "Get-StorageGroups.xml"
$Delim = " : "
Remove-Variable GetObj
$GetObj = @(Import-CLIXML $Source)

$ID = 144222
$Field = @("name","Server","SystemFolderPath","LogFolderPath")
$Label = @("Name","Server","System Path","Log Path")
$HTMLTitle = "Storage Groups"
$HTMLFile = "StorageGroups.html"
$HTMLSubTitle = $HTMLTitle
[int]$AppendFile = 0
$Sort = "Name"
$ColOrder = (2,3,4,1)
$FormattedTable = Format-Object $GetObj $Field $Label $Sort
write-progress -ID $ID -activity $HTMLTitle -status $HTMLSubTitle -percentcomplete 0
Create-File -title $HTMLTitle -Subtitle $HTMLSubTitle -append $AppendFile -table $FormattedTable -outfile $HTMLFile -colorder $ColOrder -filetype $format

write-progress -ID $ID -activity $HTMLTitle -status $HTMLSubTitle -completed
}

################################
# Process Exchange Mailbox Databases
Function Global:Docs-Ex-MBDB {
$NewRecord = "RunspaceId"
$Source = "Get-MailboxDatabase.xml"
$Delim = " : "
Remove-Variable GetObj
$GetObj = @(Import-CLIXML $Source)

$ID = 12222222
$Field = @("AdminDisplayName","EdbFilePath","LogFolderPath","IssueWarningQuota","ProhibitSendQuota","ProhibitSendReceiveQuota")
$Label = @("Name","EDB","Logs","Warning","Prohibit Send","Prohibit Send/Receive")
$HTMLTitle = "Mailbox Databases"
$HTMLFile = "MailboxDatabases.html"
$HTMLSubTitle = $HTMLTitle
[int]$AppendFile = 0
$Sort = "Name"
$ColOrder = (3,1,2,6,4,5)
$FormattedTable = Format-Object $GetObj $Field $Label $Sort
write-progress -ID $ID -activity $HTMLTitle -status $HTMLSubTitle -percentcomplete 0
Create-File -title $HTMLTitle -Subtitle $HTMLSubTitle -append $AppendFile -table $FormattedTable -outfile $HTMLFile -colorder $ColOrder -filetype $format

$Field = @("AdminDisplayName","RpcClientAccessServer","PublicFolderDatabase","BackgroundDatabaseMaintenance","Servers")
$Label = @("Name","CAS Server","Public Folders","Background Maintenance","On Servers")
$HTMLSubTitle = $HTMLTitle + " - Continued"
[int]$AppendFile = 1
$Sort = "Name"
$ColOrder = (3,2,5,1,4)
$FormattedTable = Format-Object $GetObj $Field $Label $Sort
write-progress -ID $ID -activity $HTMLTitle -status $HTMLSubTitle -percentcomplete 50
Create-File -title $HTMLTitle -Subtitle $HTMLSubTitle -append $AppendFile -table $FormattedTable -outfile $HTMLFile -colorder $ColOrder -filetype $format

write-progress -ID $ID -activity $HTMLTitle -status $HTMLSubTitle -completed
}

################################
# Process Exchange Client Access Servers
Function Global:Docs-Ex-CASURLs {
$NewRecord = "RunspaceId"
$Source = "Get-AutoDiscoverVirtualDirectory.xml"
$Delim = ":"
Remove-Variable GetObj
$GetObj = @(Import-CLIXML $Source)

$ID = 12222222
$Field = @("Server","InternalUrl","InternalAuthenticationMethods","ExternalUrl","ExternalAuthenticationMethods")
$Label = @("Server","Internal Url","Internal Authentication Methods","External Url","External Authentication Methods")
$HTMLTitle = "Client Access Server URLs"
$HTMLFile = "ClientAccessServerURLs.html"
$HTMLSubTitle = $HTMLTitle + " - Autodiscover"
[int]$AppendFile = 0
$Sort = "Server"
$ColOrder = (5,4,3,2,1)
$FormattedTable = Format-Object $GetObj $Field $Label $Sort
write-progress -ID $ID -activity $HTMLTitle -status $HTMLSubTitle -percentcomplete 0
Create-File -title $HTMLTitle -Subtitle $HTMLSubTitle -append $AppendFile -table $FormattedTable -outfile $HTMLFile -colorder $ColOrder -filetype $format

#######
$NewRecord = "RunspaceId"
$Source = "Get-ActiveSyncVirtualDirectory.xml"
$Delim = ":"
Remove-Variable GetObj
$GetObj = @(Import-CLIXML $Source)

$ID = 12222222
$Field = @("Server","InternalUrl","ExternalUrl","BasicAuthEnabled","WindowsAuthEnabled")
$Label = @("Server","Internal Url","External Url","Basic Authentication","Windows Authentication")
$HTMLTitle = "Client Access Servers"
$HTMLFile = "ClientAccessServers.html"
$HTMLSubTitle = $HTMLTitle + " - ActiveSync"
[int]$AppendFile = 1
$Sort = "Server"
$ColOrder = (4,3,2,1,5)
$FormattedTable = Format-Object $GetObj $Field $Label $Sort
write-progress -ID $ID -activity $HTMLTitle -status $HTMLSubTitle -percentcomplete 10
Create-File -title $HTMLTitle -Subtitle $HTMLSubTitle -append $AppendFile -table $FormattedTable -outfile $HTMLFile -colorder $ColOrder -filetype $format

#######
$NewRecord = "RunspaceId"
$Source = "Get-EcpVirtualDirectory.xml"
$Delim = ":"
Remove-Variable GetObj
$GetObj = @(Import-CLIXML $Source)

$ID = 12222222
$Field = @("Server","InternalUrl","InternalAuthenticationMethods","ExternalUrl","ExternalAuthenticationMethods")
$Label = @("Server","Internal Url","Internal Authentication Methods","External Url","External Authentication Methods")
$HTMLTitle = "Client Access Servers"
$HTMLFile = "ClientAccessServers.html"
$HTMLSubTitle = $HTMLTitle + " - ECP"
[int]$AppendFile = 1
$Sort = "Server"
$ColOrder = (5,4,3,2,1)
$FormattedTable = Format-Object $GetObj $Field $Label $Sort
write-progress -ID $ID -activity $HTMLTitle -status $HTMLSubTitle -percentcomplete 10
Create-File -title $HTMLTitle -Subtitle $HTMLSubTitle -append $AppendFile -table $FormattedTable -outfile $HTMLFile -colorder $ColOrder -filetype $format

#######
$NewRecord = "RunspaceId"
$Source = "Get-OABVirtualDirectory.xml"
$Delim = ":"
Remove-Variable GetObj
$GetObj = @(Import-CLIXML $Source)

$ID = 12222222
$Field = @("Server","OfflineAddressBooks","InternalUrl","InternalAuthenticationMethods","ExternalUrl","ExternalAuthenticationMethods")
$Label = @("Server","Offline Address Books","Internal Url","Internal Authentication Methods","External Url","External Authentication Methods")
$HTMLTitle = "Client Access Servers"
$HTMLFile = "ClientAccessServers.html"
$HTMLSubTitle = $HTMLTitle + " - OAB"
[int]$AppendFile = 1
$Sort = "Server"
$ColOrder = (6,5,4,3,2,1)
$FormattedTable = Format-Object $GetObj $Field $Label $Sort
write-progress -ID $ID -activity $HTMLTitle -status $HTMLSubTitle -percentcomplete 20
Create-File -title $HTMLTitle -Subtitle $HTMLSubTitle -append $AppendFile -table $FormattedTable -outfile $HTMLFile -colorder $ColOrder -filetype $format

#######
$NewRecord = "RunspaceId"
$Source = "Get-OwaVirtualDirectory.xml"
$Delim = ":"
Remove-Variable GetObj
$GetObj = @(Import-CLIXML $Source)
$GetObj = $GetObj | Where {$_.Name -like "owa*"}

$ID = 12222222
$Field = @("Server","LogonFormat","InternalUrl","InternalAuthenticationMethods","ExternalUrl","ExternalAuthenticationMethods")
$Label = @("Server","Logon Format","Internal Url","Internal Authentication Methods","External Url","External Authentication Methods")
$HTMLTitle = "Client Access Servers"
$HTMLFile = "ClientAccessServers.html"
$HTMLSubTitle = $HTMLTitle + " - OWA"
[int]$AppendFile = 1
$Sort = "Server"
$ColOrder = (6,5,4,3,2,1)
$FormattedTable = Format-Object $GetObj $Field $Label $Sort
write-progress -ID $ID -activity $HTMLTitle -status $HTMLSubTitle -percentcomplete 30
Create-File -title $HTMLTitle -Subtitle $HTMLSubTitle -append $AppendFile -table $FormattedTable -outfile $HTMLFile -colorder $ColOrder -filetype $format

#######
$NewRecord = "RunspaceId"
$Source = "Get-WebServicesVirtualDirectory.xml"
$Delim = ":"
Remove-Variable GetObj
$GetObj = @(Import-CLIXML $Source)

$ID = 12222222
$Field = @("Server","InternalUrl","InternalAuthenticationMethods","ExternalUrl","ExternalAuthenticationMethods")
$Label = @("Server","Internal Url","Internal Authentication Methods","External Url","External Authentication Methods")
$HTMLTitle = "Client Access Servers"
$HTMLFile = "ClientAccessServers.html"
$HTMLSubTitle = $HTMLTitle + " - EWS"
[int]$AppendFile = 1
$Sort = "Server"
$ColOrder = (5,4,3,2,1)
$FormattedTable = Format-Object $GetObj $Field $Label $Sort
write-progress -ID $ID -activity $HTMLTitle -status $HTMLSubTitle -percentcomplete 40
Create-File -title $HTMLTitle -Subtitle $HTMLSubTitle -append $AppendFile -table $FormattedTable -outfile $HTMLFile -colorder $ColOrder -filetype $format


write-progress -ID $ID -activity $HTMLTitle -status $HTMLSubTitle -completed
}

################################
# Process Exchange Mailbox Databases
Function Global:Docs-Ex-ReceiveConnector {
$NewRecord = "RunspaceId"
$Source = "Get-ReceiveConnector.xml"
$Delim = " : "
Remove-Variable GetObj
$GetObj = @(Import-CLIXML $Source)

$ID = 12222222
$Field = @("Name","Bindings","RemoteIPRanges","MaxMessageSize","MaxRecipientsPerMessage","PermissionGroups","AuthMechanism")
$Label = @("Name","Bindings","Remote IP","Max Message Size","Max Recipients","Allowed Groups","Authentication")
$HTMLTitle = "Receive Connectors"
$HTMLFile = "ReceiveConnectors.html"
$HTMLSubTitle = $HTMLTitle
[int]$AppendFile = 0
$Sort = "Name"
$ColOrder = (6,3,7,4,5,1,2)
$FormattedTable = Format-Object $GetObj $Field $Label $Sort
write-progress -ID $ID -activity $HTMLTitle -status $HTMLSubTitle -percentcomplete 0
Create-File -title $HTMLTitle -Subtitle $HTMLSubTitle -append $AppendFile -table $FormattedTable -outfile $HTMLFile -colorder $ColOrder -filetype $format

write-progress -ID $ID -activity $HTMLTitle -status $HTMLSubTitle -completed
}

################################
# Process Exchange Mailbox Databases
Function Global:Docs-Ex-SendConnector {
$NewRecord = "AddressSpaces"
$Source = "Get-SendConnector.xml"
$Delim = " : "
Remove-Variable GetObj
$GetObj = @(Import-CLIXML $Source)

$ID = 12222222
$Field = @("Name","SourceTransportServers","AddressSpaces","SmartHosts","DNSRoutingEnabled","MaxMessageSize")
$Label = @("Name","Source Servers","Address Space","Smart Host","DNS Enabled","Max Message Size")
$HTMLTitle = "Send Connectors"
$HTMLFile = "SendConnectors.html"
$HTMLSubTitle = $HTMLTitle
[int]$AppendFile = 0
$Sort = "Name"
$ColOrder = (4,6,1,5,2,3)
$FormattedTable = Format-Object $GetObj $Field $Label $Sort
write-progress -ID $ID -activity $HTMLTitle -status $HTMLSubTitle -percentcomplete 0
Create-File -title $HTMLTitle -Subtitle $HTMLSubTitle -append $AppendFile -table $FormattedTable -outfile $HTMLFile -colorder $ColOrder -filetype $format

write-progress -ID $ID -activity $HTMLTitle -status $HTMLSubTitle -completed
}

################################
# Process Exchange Foreign Connectors
Function Global:Docs-Ex-ForeignConnector {
$NewRecord = "RunspaceId"
$Source = "Get-ForeignConnector.xml"
$Delim = " : "
Remove-Variable GetObj
$GetObj = @(Import-CLIXML $Source)

$ID = 12222222
$Field = @("Name","SourceTransportServers","AddressSpaces","Enabled","ConnectedDomains")
$Label = @("Name","Source Servers","Address Space","Enabled","Domains")
$HTMLTitle = "Foreign Connectors"
$HTMLFile = "ForeignConnectors.html"
$HTMLSubTitle = $HTMLTitle
[int]$AppendFile = 0
$Sort = "Name"
$ColOrder = (4,5,1,3,2)
$FormattedTable = Format-Object $GetObj $Field $Label $Sort
write-progress -ID $ID -activity $HTMLTitle -status $HTMLSubTitle -percentcomplete 0
Create-File -title $HTMLTitle -Subtitle $HTMLSubTitle -append $AppendFile -table $FormattedTable -outfile $HTMLFile -colorder $ColOrder -filetype $format

write-progress -ID $ID -activity $HTMLTitle -status $HTMLSubTitle -completed
}

################################
# Process Exchange Mailbox Databases
Function Global:Docs-Ex-EmailAddressPolicy {
$NewRecord = "RunspaceId"
$Source = "Get-EmailAddressPolicy.xml"
$Delim = " : "
Remove-Variable GetObj
$GetObj = @(Import-CLIXML $Source)
$GetObj | ForEach-Object {
  # Format attributes
  if ($_.RecipientFilterType -eq "Precanned") {$_.RecipientFilter = $_.IncludedRecipients}
}

$ID = 166222
$Field = @("name","RecipientFilter","LdapRecipientFilter","EnabledPrimarySMTPAddressTemplate","EnabledEmailAddressTemplates")
$Label = @("Name","Filter","LADP Filter","Primary SMTP Address","Other Addresses")
$HTMLTitle = "Email Address Policies"
$HTMLFile = "EmailAddressPolicies.html"
$HTMLSubTitle = $HTMLTitle
[int]$AppendFile = 0
$Sort = "Name"
$ColOrder = (3,1,2,5,4)
$FormattedTable = Format-Object $GetObj $Field $Label $Sort
write-progress -ID $ID -activity $HTMLTitle -status $HTMLSubTitle -percentcomplete 0
Create-File -title $HTMLTitle -Subtitle $HTMLSubTitle -append $AppendFile -table $FormattedTable -outfile $HTMLFile -colorder $ColOrder -filetype $format

write-progress -ID $ID -activity $HTMLTitle -status $HTMLSubTitle -completed
}

################################
# Process Exchange Mailbox Databases
Function Global:Docs-Ex-AddressList {
$NewRecord = "RunspaceId"
$Source = "Get-AddressList.xml"
$Delim = " : "
Remove-Variable GetObj
$GetObj = @(Import-CLIXML $Source)
$GetObj | ForEach-Object {
  # Format attributes
  if ($_.RecipientFilterType -eq "Precanned") {$_.RecipientFilter = $_.IncludedRecipients}
}

$ID = 166222
$Field = @("name","Container","RecipientFilter","LdapRecipientFilter")
$Label = @("Name","Container","Filter","LADP Filter")
$HTMLTitle = "Address Lists"
$HTMLFile = "AddressLists.html"
$HTMLSubTitle = $HTMLTitle
[int]$AppendFile = 0
$Sort = "Name"
$ColOrder = (4,1,2,3)
$FormattedTable = Format-Object $GetObj $Field $Label $Sort
write-progress -ID $ID -activity $HTMLTitle -status $HTMLSubTitle -percentcomplete 0
Create-File -title $HTMLTitle -Subtitle $HTMLSubTitle -append $AppendFile -table $FormattedTable -outfile $HTMLFile -colorder $ColOrder -filetype $format

write-progress -ID $ID -activity $HTMLTitle -status $HTMLSubTitle -completed
}

################################
# Process Exchange Offline Address Books
Function Global:Docs-Ex-OAB {
$NewRecord = "RunspaceId"
$Source = "Get-OfflineAddressBook.xml"
$Delim = " : "
Remove-Variable GetObj
$GetObj = @(Import-CLIXML $Source)

$ID = 144222
$Field = @("name","Server","AddressLists","VirtualDirectories","IsDefault")
$Label = @("Name","Server","Address Lists","Virtual Directories","Default")
$HTMLTitle = "Offline Address Books"
$HTMLFile = "OfflineAddressBooks.html"
$HTMLSubTitle = $HTMLTitle
[int]$AppendFile = 0
$Sort = "Name"
$ColOrder = (2,3,4,1)
$FormattedTable = Format-Object $GetObj $Field $Label $Sort
write-progress -ID $ID -activity $HTMLTitle -status $HTMLSubTitle -percentcomplete 0
Create-File -title $HTMLTitle -Subtitle $HTMLSubTitle -append $AppendFile -table $FormattedTable -outfile $HTMLFile -colorder $ColOrder -filetype $format

write-progress -ID $ID -activity $HTMLTitle -status $HTMLSubTitle -completed
}

################################
# Process Exchange Mailbox Databases
Function Global:Docs-Ex-RBAC {
$NewRecord = "RunspaceId"
$Source = "Get-RoleGroup.xml"
$Delim = " : "
Remove-Variable GetObj
$GetObj = @(Import-CLIXML $Source)
$GetObj | ForEach-Object {
  # Format attributes
  $Domain = (($_.Identity).split("/"))[0]
}

$ID = 166222
$Field = @("name","Members","Description")
$Label = @("Name","Members","Description")
$HTMLTitle = "Role Based Access Control"
$HTMLFile = "RoleBasedAccessControl.html"
$HTMLSubTitle = $HTMLTitle
[int]$AppendFile = 0
$Sort = "Name"
$ColOrder = (3,2,1)
$FormattedTable = Format-Object $GetObj $Field $Label $Sort
write-progress -ID $ID -activity $HTMLTitle -status $HTMLSubTitle -percentcomplete 0
Create-File -title $HTMLTitle -Subtitle $HTMLSubTitle -append $AppendFile -table $FormattedTable -outfile $HTMLFile -colorder $ColOrder -filetype $format

write-progress -ID $ID -activity $HTMLTitle -status $HTMLSubTitle -completed
}

################################
# Process Hardware Specs and create HTML/Word file
Function Global:Docs-EX-Hardware {
  Param ($CRLF = ";;")
  
  $Source = "Get-Hardware.xml"
#  $GetObj = File-To-Object "Get-Hardware.txt" ":" "NewRecord"
#  $GetObj = $Hardware | %{($_.servername).trim() | get-HardwareInventory}
  Remove-Variable GetObj
  $GetObj = @(Import-CLIXML $Source)

  $HTMLTitle = "Exchange Server Hardware"
  $HTMLFile = "ExHardware.html"
  $HTMLSubTitle = $HTMLTitle
[int]$AppendFile = 0
  $Field = @("CSName","ComputerManufacturer","ComputerModel","OSName","OSVersion","SPVersion","TotalMemory")
  $Label = @("Server","Manufacturer","Model","Operating System","OS Ver","OS SP","RAM")
  $Sort = "CSName"
  $ColOrder = (7,1,2,3,5,4,6)
  $FormattedTable = Format-Object $GetObj $Field $Label $Sort
  Create-File -title $HTMLTitle -Subtitle $HTMLSubTitle -append $AppendFile -table $FormattedTable -outfile $HTMLFile -colorder $ColOrder -filetype $format 

  $Field = @("CSName","ProcessorDeviceID","ProcessorName","ProcessorCaption","ProcessorCount","ProcessorCores","ProcessorSpeed")
  $Label = @("Server","CPU ID","CPU Name","CPU Caption","Num CPUs","Cores per CPU","CPU Speed")
  $HTMLSubTitle = $HTMLTitle+" - CPU"
  [int]$AppendFile = 1
  $Sort = "CSName"
  $ColOrder = (7,3,4,2,6,1,5)
  $FormattedTable = Format-Object $GetObj $Field $Label $Sort
  Create-File -title $HTMLTitle -Subtitle $HTMLSubTitle -append $AppendFile -table $FormattedTable -outfile $HTMLFile -colorder $ColOrder -filetype $format 

  $Field = @("CSName","Disk","Size","DiskDescription","DriveType","MediaType")
  $Label = @("Server","Physical Disks","Disk Size","Description","Type","Media")
  $HTMLSubTitle = $HTMLTitle+" - Disk"
  $Sort = "CSName"
  $ColOrder = (5,4,2,1,6,3)
  $FormattedTable = Format-Object $GetObj $Field $Label $Sort
  Create-File -title $HTMLTitle -Subtitle $HTMLSubTitle -append $AppendFile -table $FormattedTable -outfile $HTMLFile -colorder $ColOrder -filetype $format 

  $Field = @("CSName","LogicalDrives","VolumeName","LogicalDriveSize","DriveFreeSpace")
  $Label = @("Server","Logical Drives","Volume Name","Size","Free Space")
  $HTMLSubTitle = $HTMLTitle+" - Volume"
  $Sort = "CSName"
  $ColOrder = (3,2,5,4,1)
  $FormattedTable = Format-Object $GetObj $Field $Label $Sort
  Create-File -title $HTMLTitle -Subtitle $HTMLSubTitle -append $AppendFile -table $FormattedTable -outfile $HTMLFile -colorder $ColOrder -filetype $format 

  $Field = @("CSName","NICCount","NICDesc","DHCPEnabled","IPAddress","SubnetMask","Gateway","MACAddress","DNSServerSearchOrder","WINSPrimaryServer","WINSSecondaryServer")
  $Label = @("Server","Num NICs","NIC","DHCP","IP Address","Subnet","Gateway","MAC Address","DNS","Primary WINS","Secondary WINS")
  $HTMLSubTitle = $HTMLTitle+" - NIC"
  $Sort = "CSName"
  $ColOrder = (10,7,6,1,4,11,3,5,2,8,9)
  $FormattedTable = Format-Object $GetObj $Field $Label $Sort
  Create-File -title $HTMLTitle -Subtitle $HTMLSubTitle -append $AppendFile -table $FormattedTable -outfile $HTMLFile -colorder $ColOrder -filetype $format 

  $Field = @("CSName","BIOS","BIOSVersion","BIOSSerial")
  $Label = @("Server","BIOS","BIOS Version","BIOS Serial")
  $HTMLSubTitle = $HTMLTitle+" - BIOS"
  $Sort = "CSName"
  $ColOrder = (4,1,3,2)
  $FormattedTable = Format-Object $GetObj $Field $Label $Sort
  Create-File -title $HTMLTitle -Subtitle $HTMLSubTitle -append $AppendFile -table $FormattedTable -outfile $HTMLFile -colorder $ColOrder -filetype $format 

}

################################
# Create Exchange Documentation
Function Global:Docs-Exch-ToFile {
param ($Format = "HTML")

# Load supporting PS scripts
.\Create-Docs-Functions.ps1
.\Excel.ps1
.\Functions-HTML.ps1
.\Word.ps1

$Format = "WORD"

if ($Format -eq "WORD") {
  WORD\Invoke-Word -Orientation 1
  WORD\Add-TableOfContents
  WORD\Add-PageBreak
}

$ID = 5438547
$Increment = 8
$PctComplete = 0


write-progress -ID $ID -activity "Creating $Format Documentation" -status "Accepted Domains" -percentcomplete $PctComplete
Docs-Ex-AcceptedDomain
$PctComplete += $Increment

write-progress -ID $ID -activity "Creating $Format Documentation" -status "Remote Domains" -percentcomplete $PctComplete
Docs-Ex-RemoteDomain
$PctComplete += $Increment

write-progress -ID $ID -activity "Creating $Format Documentation" -status "Mailbox Servers" -percentcomplete $PctComplete
Docs-Ex-MBXServers
$PctComplete += $Increment

write-progress -ID $ID -activity "Creating $Format Documentation" -status "Database Availability Groups" -percentcomplete $PctComplete
Docs-Ex-DAG
$PctComplete += $Increment

write-progress -ID $ID -activity "Creating $Format Documentation" -status "Storage Groups" -percentcomplete $PctComplete
Docs-Ex-StorageGroups
$PctComplete += $Increment

write-progress -ID $ID -activity "Creating $Format Documentation" -status "Mailbox Databases" -percentcomplete $PctComplete
Docs-Ex-MBDB
$PctComplete += $Increment

write-progress -ID $ID -activity "Creating $Format Documentation" -status "Client Access Servers" -percentcomplete $PctComplete
Docs-Ex-CAServers
$PctComplete += $Increment

write-progress -ID $ID -activity "Creating $Format Documentation" -status "CAS Array" -percentcomplete $PctComplete
Docs-Ex-CASArray
$PctComplete += $Increment

write-progress -ID $ID -activity "Creating $Format Documentation" -status "CAS URLs" -percentcomplete $PctComplete
Docs-Ex-CASURLs
$PctComplete += $Increment

write-progress -ID $ID -activity "Creating $Format Documentation" -status "Hub Transport Servers" -percentcomplete $PctComplete
Docs-Ex-HTServers
$PctComplete += $Increment

write-progress -ID $ID -activity "Creating $Format Documentation" -status "Receive Connectors" -percentcomplete $PctComplete
Docs-Ex-ReceiveConnector
$PctComplete += $Increment

write-progress -ID $ID -activity "Creating $Format Documentation" -status "Send Connectors" -percentcomplete $PctComplete
Docs-Ex-SendConnector
$PctComplete += $Increment

write-progress -ID $ID -activity "Creating $Format Documentation" -status "Foreign Connectors" -percentcomplete $PctComplete
Docs-Ex-ForeignConnector
$PctComplete += $Increment

write-progress -ID $ID -activity "Creating $Format Documentation" -status "Email Address Policies" -percentcomplete $PctComplete
Docs-Ex-EmailAddressPolicy
$PctComplete += $Increment

write-progress -ID $ID -activity "Creating $Format Documentation" -status "Address Lists" -percentcomplete $PctComplete
Docs-Ex-AddressList
$PctComplete += $Increment

write-progress -ID $ID -activity "Creating $Format Documentation" -status "Offline Address Books" -percentcomplete $PctComplete
Docs-Ex-OAB
$PctComplete += $Increment

write-progress -ID $ID -activity "Creating $Format Documentation" -status "RBAC" -percentcomplete $PctComplete
Docs-Ex-RBAC
$PctComplete += $Increment

write-progress -ID $ID -activity "Creating $Format Documentation" -status "Hardware" -percentcomplete $PctComplete
Docs-Hardware
$PctComplete += $Increment

write-progress -ID $ID -activity "Creating $Format Documentation" -Status "Done" -completed

}
