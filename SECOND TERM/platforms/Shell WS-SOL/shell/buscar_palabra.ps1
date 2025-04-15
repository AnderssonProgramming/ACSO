# Script to search for a word in a specified file

# Clear the screen
Clear-Host

# Check if correct number of parameters were provided
if ($args.Count -ne 2) {
    Write-Host "Error: Se requieren dos parámetros."
    Write-Host "Uso: .\buscar_palabra.ps1 <palabra_buscada> <archivo_de_busqueda>"
    exit 1
}

# Get parameters
$palabra = $args[0]
$archivo = $args[1]

# Check if the file exists
if (-not (Test-Path -Path $archivo)) {
    Write-Host "Error: El archivo '$archivo' no existe."
    exit 1
}

# Search for the word in the file
Write-Host "Buscando '$palabra' en el archivo '$archivo':"
Write-Host "----------------------------------------"

# Using Select-String which is PowerShell's equivalent to grep
$resultados = Select-String -Path $archivo -Pattern $palabra -SimpleMatch
if ($resultados) {
    $resultados | ForEach-Object { Write-Host $_.Line }
    Write-Host "----------------------------------------"
    Write-Host "Se encontraron $($resultados.Count) coincidencias."
} else {
    Write-Host "No se encontraron coincidencias para '$palabra'."
}