# Restores the Scoop export from the above directory

$ExportPath = "$PSScriptRoot/../scoop-export.json"

$Export = Get-Content $ExportPath | ConvertFrom-Json

ForEach ($Bucket in $Export.buckets)
{
    scoop bucket add $Bucket.Name $Bucket.Source
}

ForEach ($App in $Export.apps)
{
    $Source = $App.Source
    $Name = $App.Name

    scoop install "$Source/$Name"
}
