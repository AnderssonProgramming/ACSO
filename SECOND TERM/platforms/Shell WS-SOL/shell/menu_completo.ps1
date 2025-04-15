# Menu program for Windows PowerShell
# This script displays a menu and executes the selected previous exercises

function Show-Menu {
    Clear-Host
    Write-Host "==========================================="
    Write-Host "    MENU DE PROGRAMAS SHELL - WINDOWS"
    Write-Host "==========================================="
    Write-Host "1. Hello World"
    Write-Host "2. Número de líneas en C:\Windows\System32\drivers\etc\hosts"
    Write-Host "3. Buscar palabra en archivo"
    Write-Host "4. Extraer usuarios y descripción"
    Write-Host "5. Buscar archivos con permisos específicos"
    Write-Host "6. Verificar tipo de archivo"
    Write-Host "7. Mostrar accesos administrativos"
    Write-Host "8. Terminar"
    Write-Host "==========================================="
    Write-Host "Seleccione una opción (1-8): " -NoNewline
}

# Main program loop
$running = $true
while ($running) {
    # Display the menu
    Show-Menu
    
    # Read user input
    $option = Read-Host
    
    # Process the selected option using switch statement (PowerShell's equivalent to case)
    switch ($option) {
        "1" {
            Write-Host "Ejecutando programa Hello World..."
            # Suponiendo que el script se llama hello_world.ps1
            & ".\hello.ps1"
            Read-Host "Presione Enter para continuar..."
        }
        "2" {
            Write-Host "Ejecutando programa de conteo de líneas..."
            # Suponiendo que el script se llama contar_lineas.ps1
            & ".\count_lines.ps1"
            Read-Host "Presione Enter para continuar..."
        }
        "3" {
            Write-Host "Ejecutando programa de búsqueda de palabras..."
            $palabra = Read-Host "Ingrese la palabra a buscar"
            $archivo = Read-Host "Ingrese el archivo donde buscar"
            # Suponiendo que el script se llama buscar_palabra.ps1
            & ".\buscar_palabra.ps1" $palabra $archivo
            Read-Host "Presione Enter para continuar..."
        }
        "4" {
            Write-Host "Ejecutando programa de extracción de usuarios..."
            # Suponiendo que el script se llama extraer_usuarios.ps1
            & ".\extraer_usuarios.ps1"
            Read-Host "Presione Enter para continuar..."
        }
        "5" {
            Write-Host "Ejecutando programa de búsqueda de archivos por permisos..."
            $directorio = Read-Host "Ingrese el directorio donde buscar"
            $permisos = Read-Host "Ingrese los permisos a buscar (ejemplo: FullControl)"
            # Suponiendo que el script se llama buscar_archivos.ps1
            & ".\buscar_archivos.ps1" $directorio $permisos
            Read-Host "Presione Enter para continuar..."
        }
        "6" {
            Write-Host "Ejecutando programa para verificar tipo de archivo..."
            $rutaArchivo = Read-Host "Ingrese la ruta del archivo a verificar"
            # Suponiendo que el script se llama verificar_tipo.ps1
            & ".\verificar_tipo.ps1" $rutaArchivo
            Read-Host "Presione Enter para continuar..."
        }
        "7" {
            Write-Host "Ejecutando programa para mostrar accesos administrativos..."
            # Suponiendo que el script se llama accesos_root.ps1
            & ".\accesos_root.ps1"
            Read-Host "Presione Enter para continuar..."
        }
        "8" {
            Write-Host "Saliendo del programa. ¡Hasta luego!"
            $running = $false
        }
        default {
            Write-Host "Opción inválida. Por favor, seleccione una opción válida (1-8)."
            Read-Host "Presione Enter para continuar..."
        }
    }
}