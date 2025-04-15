# Script para verificar si un elemento es un archivo, un subdirectorio u otra cosa
# Uso: .\verificar_tipo.ps1 nombre_elemento directorio_busqueda

$Nombre = $args[0]
$Directorio = $args[1]

# Verificar que se hayan proporcionado los dos parámetros
if ($args.Count -lt 2) {
    Write-Host "Error: Debe proporcionar un nombre y un directorio." -ForegroundColor Red
    Write-Host "Uso: .\verificar_tipo.ps1 nombre_elemento directorio_busqueda"
    exit 1
}

# Verificar si el directorio existe
if (-not (Test-Path $Directorio)) {
    Write-Host "Error: El directorio '$Directorio' no existe." -ForegroundColor Red
    exit 1
}

# Construir la ruta completa del elemento
$RutaCompleta = "$Directorio\$Nombre"

# Verificar el tipo de elemento
if (Test-Path $RutaCompleta -PathType Leaf) {
    Write-Host "'$Nombre' es un archivo en el directorio '$Directorio'." -ForegroundColor Green
}
elseif (Test-Path $RutaCompleta -PathType Container) {
    Write-Host "'$Nombre' es un subdirectorio dentro de '$Directorio'." -ForegroundColor Green
}
elseif (Test-Path $RutaCompleta) {
    Write-Host "'$Nombre' existe en '$Directorio' pero no es un archivo ni un subdirectorio." -ForegroundColor Yellow
}
else {
    Write-Host "'$Nombre' no existe en el directorio '$Directorio'." -ForegroundColor Red
}

exit 0