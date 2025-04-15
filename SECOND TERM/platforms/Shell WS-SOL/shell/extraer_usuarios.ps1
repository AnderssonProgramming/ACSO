# Definir el archivo de salida
$ARCHIVO_SALIDA = "usuariosP_descripcion.txt"

# Limpiar el archivo de salida si ya existe
if (Test-Path $ARCHIVO_SALIDA) {
    Clear-Content $ARCHIVO_SALIDA
}

# Encabezado del archivo de salida
"================================================" | Out-File -FilePath $ARCHIVO_SALIDA
"USUARIO | DESCRIPCIÓN" | Out-File -FilePath $ARCHIVO_SALIDA -Append
"================================================" | Out-File -FilePath $ARCHIVO_SALIDA -Append

# Obtener información de usuarios locales
Write-Host "Extrayendo información de usuarios..."
$usuarios = Get-LocalUser | Select-Object Name, Description

# Escribir la información en el archivo de salida
foreach ($usuario in $usuarios) {
    # Solo incluir usuarios que tengan una descripción
    if ($usuario.Description) {
        "$($usuario.Name) | $($usuario.Description)" | Out-File -FilePath $ARCHIVO_SALIDA -Append
    }
}

Write-Host "La información ha sido guardada en $ARCHIVO_SALIDA"
Write-Host "Contenido del archivo de salida:"
Write-Host "--------------------------------"
Get-Content $ARCHIVO_SALIDA

exit 0
