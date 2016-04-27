<#Date:November 7,2015
﻿#This scrip is used to locate empty folders and delete them, find the three largest processes running on the system,
﻿#find and save all installed software on the system to a file and create a CSV file.
#Authors: Michael Thomas,Angie Dacosta,Zeechan (Group A)
#>
function menu ([string]$Title,[array] $MenuOption)
{
#####Menu characters,title and options###################################################################
$BoxCharacters=@("╔","═","╗","║","╚","╝","╠","╣"," ")
$MenuOption=@("1. Find the largest processes","2. Log system inventory","3. Create CSV files", "4. Find empty folders", "5. Exit program")
$Title="Win213"
####Creating menu####################################################################################################
Write-Host "$($BoxCharacters[0])$($BoxCharacters[1]*50)$($BoxCharacters[2])"
Write-Host "$($BoxCharacters[3])$($Title.PadLeft(27))$($BoxCharacters[8]*23)$($BoxCharacters[3])" 
Write-Host "$($BoxCharacters[3])$($BoxCharacters[8]*50)$($BoxCharacters[3])"
Write-Host "$($BoxCharacters[6])$($BoxCharacters[1]*50)$($BoxCharacters[7])"
Write-Host "$($BoxCharacters[3])$($BoxCharacters[8]*6)$($MenuOption[0])$($BoxCharacters[8]*15)$($BoxCharacters[3])"
Write-Host "$($BoxCharacters[3])$($BoxCharacters[8]*6)$($MenuOption[1])$($BoxCharacters[8]*21)$($BoxCharacters[3])"
Write-Host "$($BoxCharacters[3])$($BoxCharacters[8]*6)$($MenuOption[2])$($BoxCharacters[8]*25)$($BoxCharacters[3])"
Write-Host "$($BoxCharacters[3])$($BoxCharacters[8]*6)$($MenuOption[3])$($BoxCharacters[8]*23)$($BoxCharacters[3])"
Write-Host "$($BoxCharacters[3])$($BoxCharacters[8]*6)$($MenuOption[4])$($BoxCharacters[8]*29)$($BoxCharacters[3])"
Write-Host "$($BoxCharacters[4])$($BoxCharacters[1]*50)$($BoxCharacters[5])"
#######User enters choice from menu items#####################################
$UserChoice= Read-Host "Choose an option from the menu above"
####Read user choice and call appropritate function###############################
switch ($UserChoice)
{
   1 { Large-Process }
   2 { System-Inventory }
   3 { CSV-Files }
   4 { Empty-Folders}
   5 { exit }
    
}

} 
function color ()
{
###########Function to change the color of the text in the menu###########################

     $Host.UI.RawUI.ForegroundColor="Green"
}
function Large-process () 
{
    $Date= Get-Date
    $ProcessFolder="$HOME\desktop\process"
    $ProcessFile="$HOME\desktop\process\cpuprocess.txt"
    $RunningProcesses= Get-Process | Where-Object{$_.CPU -gt 1} | Select-Object -Property name,cpu | sort -Descending -Property cpu | Select-Object -First 3
################# Testing if the required folders and file exist. If not create it##########################################################################
        if ((Test-Path -Path $ProcessFolder )-eq $false)
        {
            Write-Host "Directory not found and is being created"
            New-Item -Path $ProcessFolder -ItemType directory 
            New-Item -Path $ProcessFolder\cpuprocess.txt -ItemType file 
            Write-Host "Please wait......"
            Start-Sleep -s 10
            }
############## If the file exist, ask user to delete or continue############################################################################################
        elseif ((test-path -Path $ProcessFile)-eq $true)
        {
        
        Write-Host "Directory exits. Delete it?" -ForegroundColor Red
        
        }
#############Prompt user to enter a choice and call the appropriate switch option based on choice###########################################################
        $UserResponse=Read-host "Continue? [Y\N] N exits the program and deletes the folders "


         switch ($UserResponse)
        {
           n {Remove-Item $ProcessFile;exit}
           y {Write-Output "================================================="| Out-File -FilePath $ProcessFile
              Write-Output $Date | Out-File -FilePath $ProcessFile -Append
              Write-Output "=================================================" | Out-File -FilePath $ProcessFile -Append
              Write-Output $RunningProcesses | Out-File -FilePath $ProcessFile -Append}
           
         }
         Clear-Host
         menu # CALL MENU 
    #END FUNCTION
}
function System-Inventory ($logPath ="C:\backup\log\sys.log")
{  
    $Log = "C:\backup\log" 
    $Path = "C:\backup"
########Test for sys.log file. If not found create it.###############################################################
    if ((Test-Path $logPath)-eq $false)
        {New-Item -Path  $Path -ItemType directory -ErrorAction SilentlyContinue | Out-Null
        New-Item -Path  $Log -ItemType directory -ErrorAction SilentlyContinue | Out-Null
        New-Item -Path  $logPath -ItemType file | Out-Null
        Clear-Host
      Write-Host "Directory Created"}

    elseif ((Test-Path $logPath)-eq $true)
    {
    Write-Host "$logPath already exist,do you want to delete the file?" -ForegroundColor Red

    $UserResponse = Read-Host "[Y/N}"

    switch ($UserResponse)
    {
        y {Remove-Item $logPath;menu }
        n {}
    }
     }
 ##### Variables to store system information#######################################################################
 $Date = Get-Date
 $ComputerName= Get-WmiObject Win32_ComputerSystem
 $FullComputerName = $ComputerName.name  
 $Software = Get-CimInstance  Win32_product
 $OperatingVersion = Get-CimInstance Win32_OperatingSystem 
 $OperatingSystem = Get-CimInstance Win32_OperatingSystem 
 $NetworkSettings = Get-CimInstance win32_NetworkAdapterConfiguration | Where-Object IPEnabled -Match "true" 
 #######Prompt user to press enter to continue###############################################################################################################
 Clear-Host
 Write-Host "Loading completed"
 pause 
########Writing date and computer name to the top of the log file###################################################################################################
Write-Output "$Date" | Out-file -FilePath $logPath -encoding ASCII
Write-Output "====================================================================================================" | Out-file -FilePath "$logPath"  -encoding ASCII -append
Write-Output "Computer: $FullComputerName" | Out-file -FilePath $logPath -encoding ASCII
Write-Output "====================================================================================================" | Out-file -FilePath "$logPath"  -encoding ASCII -append
####OS Information#######################################################
Write-Output "`n`n`n`n" | Add-Content  "$logPath" 
Write-Output "Operating System" | Add-Content "$logPath"
Write-Output "====================================================================================================" | Out-file -FilePath "$logPath"  -encoding ASCII –append
Foreach-Object -InputObject ($OperatingSystem | Select-Object name | Out-String -Width 90) { Write-Output $_ | Add-Content "$logPath"}
####OS Version#########################################################################################
Write-Output "`n`n`n`n" | Add-Content  "$logPath" 
Write-Output "`n`n`n`n" | Add-Content  "$logPath" 
Write-Output "Operating Version" | Add-Content "$logPath"
Write-Output "====================================================================================================" | Out-file -FilePath "$logPath"  -encoding ASCII –append
Foreach-Object -InputObject ($OperatingVersion | Select-Object version | Out-String -Width 90) { Write-Output $_ | Add-Content "$logPath"}
###Network Settings######################################################################################
Write-Output "`n`n`n`n" | Add-Content  "$logPath" 
Write-Output "`n`n`n`n" | Add-Content  "$logPath" 
Write-Output "Network Settings" | Add-Content "$logPath"
Write-Output "====================================================================================================" | Out-file -FilePath "$logPath"  -encoding ASCII –append
Foreach-Object -InputObject ($NetworkSettings | Select-Object -Property Description,IPAddress,MACAddress | Out-String -Width 90) { Write-Output $_ | Add-Content "$logPath"}
####Installed Software#####################################################################################
Write-Output "`n`n`n`n" | Add-Content  "$logPath" 
Write-Output "`n`n`n`n" | Add-Content  "$logPath" 
Write-Output "Installed Software" | Add-Content "$logPath"
Write-Output "====================================================================================================" | Out-file -FilePath "$logPath"  -encoding ASCII –append
Foreach-Object -InputObject ($Software | Select-Object -Property name,vendor | Out-String -Width 90) { Write-Output $_ | Add-Content "$logPath"}
Clear-Host
 menu # CALL MENU
 #END FUNCTION
} 
function CSV-Files ()
{
####### Store csv headers and csv file############################################################################
    $CsvFile = "$HOME\desktop\Users.csv" 
    $CsvHeaders = @"
"GivenName", "SurName", "DisplayName", "SamAccountName", "PrincipleName", "EmailAddress", "EmployeeID",
"@
####### Create csv file with headers###############################################################################
$CsvHeaders >> $CsvFile
##### Prompt user to enter first and last name and keep looping while user enters y#######################################################
do
{
    
    $FirstName = Read-Host " Enter first name" 
    $SurName = Read-Host "Enter last name"
    $Displayname = $FirstName +" " +  $SurName
    $SamAccountName = $FirstName+$SurName 
    $PrincipleName = $FirstName+$SurName +"@"+"learnname.loc"
    $EmailAddress = $FirstName+$SurName +"@"+"learnname.loc"
    $EmployeeID = Get-Random -Minimum 100 -Maximum 1000
    $FirstName +"," +$SurName+"," + $Displayname+"," + $SamAccountName+"," +$PrincipleName+"," +  $EmailAddress+"," +  $EmployeeID+","  | Out-File $CsvFile -Append
    $UserResponse = Read-Host "Enter another name? [Y/N]"
    }
while ($UserResponse -eq "y")
Clear-Host
menu # CALL MENU
#END FUNCTION 
} 
Function Empty-Folders ($env:HOMEDRIVE)
{
####VARAIABLE TO STORE DELETED FOLDERS FILE##############################################################
   $DeletedFolders="$HOME\desktop\Deleted_Folders\DeletedFolders.txt"
   $Folders= "$HOME\desktop\Deleted_Folders"
####VARIABLES TO STORE EMPTY FOLDERS AND THE FULL PATH###################################################
   $FolderInfo= Get-ChildItem  -path    $env:HOMEDRIVE -Recurse | Where-Object{$_.PSIsContainer -eq $true}  | Where-Object{$_.GetFiles().Count -eq 0}
   $EmptyFolders= $FolderInfo.FullName
#####Test to see if the folder exits if not create it###################################################
if ((Test-Path -path $DeletedFolders)-eq- $false)
{
  Write-Host "The required folders/files does not exist. Do you want to create it?"
 $Respose= Read-host "Y creates  the folders and file N exits the program"
  switch ($Respose)
 {
    y {  New-Item -Path $Folders -ItemType directory
          New-Item -Path $DeletedFolders -ItemType file
          Write-Host "A txt file was created in $Folders listing all empty folders that was deleted" -ForegroundColor red}

    n {exit }
      
 }
}
#####Write title to file and store deleted folders in file#################################################
   Write-Output "FullName" | Out-File -FilePath $DeletedFolders
   Write-Output "============" | Out-File -FilePath $DeletedFolders -Append
   Write-Output $EmptyFolders | Out-File -FilePath $DeletedFolders -Append
#### DELETE ALL EMPTY FOLDERS###############################################################################
  if ($EmptyFolders -eq $null)
  {
      
      Write-Host "Nothing to delete"
      pause
  }
######Inform user where file was created################################################################
  Clear-Host
  menu # CALL MENU
  #END FUNCTION
} 
clear-host
#####Call color function to change text color#############################
color
####Call menu function##################################################
menu
