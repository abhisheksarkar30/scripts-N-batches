$ourfilesdata = Get-Content "C:\Users\abhisheksa\Desktop\log.txt"
#Write-Host $ourfilesdata
$ptr = 0
foreach($line in $ourfilesdata) {
    if($line -eq "END;"){
        $ptr=1
    } elseif($line.Contains("DECLARE")) {
        $ptr=0
    } elseif(($ptr -eq 1) -or ($line.Contains("ERR")) -or ($line.Contains("ORA-")) -or ($line.Contains("SP2")) -or ($line.Contains("Error report"))) {
        $ptr=1
        Add-Content "C:\Users\abhisheksa\Desktop\ex-log.txt" $line
        Write-Host $line
    }
}