# Exchange-Documentor
Microsoft Exchange Environment Documentor - 2010 and above

The GET script must be run from a PowerShell instance that has the Exchange modules already loaded

ON THE EXCHANGE SERVER:
Copy the Get-All-Exchange2010.ps1 and HardwareInventory.ps1 scripts to the server in a new folder and run it from the Exchange Management Shell. Copy all of the resulting XML files to a folder on a machine with Microsoft Office on it.

ON A WORKSTATION:
Copy the XML files created by the Get-All script as well as all PS1 files to the same folder.
Run the Create-EX-Docs.ps1 script. (This will only load some PowerShell functions into memory. It will not produce any output.)
Run the Docs-Exch-ToFile command. (This will open a new Word document and populate it with the Exchange data.)