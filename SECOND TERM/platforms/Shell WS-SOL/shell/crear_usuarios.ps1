# Este script crea 5 usuarios de prueba con descripciones
# Nota: Debe ejecutarse con privilegios de administrador

# Verificar si se está ejecutando como administrador
$esAdmin = ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)
if (-not $esAdmin) {
    Write-Host "Este script debe ejecutarse con privilegios de administrador"
    exit 1
}

# Función para crear usuario
function Crear-Usuario {
    param (
        [string]$nombre,
        [string]$descripcion,
        [string]$password = "P@ssw0rd123"
    )
    
    # Convertir la contraseña a SecureString
    $securePassword = ConvertTo-SecureString $password -AsPlainText -Force
    
    # Verificar si el usuario ya existe
    $usuarioExiste = Get-LocalUser -Name $nombre -ErrorAction SilentlyContinue
    
    if ($usuarioExiste) {
        Write-Host "El usuario '$nombre' ya existe. Actualizando descripción..."
        Set-LocalUser -Name $nombre -Description $descripcion
    } else {
        # Crear el usuario
        New-LocalUser -Name $nombre -Password $securePassword -Description $descripcion -FullName $nombre
        Write-Host "Usuario '$nombre' creado con descripción '$descripcion'"
    }
}

# Crear usuarios con descripciones
Write-Host "Creando usuarios de prueba..."

# Usuario 1
Crear-Usuario -nombre "usuario_admin" -descripcion "Administrador del Sistema"

# Usuario 2
Crear-Usuario -nombre "usuario_dev" -descripcion "Desarrollador Web"

# Usuario 3
Crear-Usuario -nombre "usuario_dba" -descripcion "Analista de Base de Datos"

# Usuario 4
Crear-Usuario -nombre "usuario_soporte" -descripcion "Soporte Técnico"

# Usuario 5
Crear-Usuario -nombre "usuario_test" -descripcion "Estudiante de Prueba"

Write-Host "Todos los usuarios han sido creados correctamente."
Write-Host "Puedes ejecutar 'Get-LocalUser usuario_*' para verificarlos."

exit 0
