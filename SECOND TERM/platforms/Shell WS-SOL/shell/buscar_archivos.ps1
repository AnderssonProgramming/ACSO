Clear-Host
if (-Not (Test-Path $args[0])) {
    Write-Output "El directorio $args[0] no existe."
    exit
}
Get-ChildItem -Path $args[0] | Where-Object { $_.Attributes -match $args[1] }