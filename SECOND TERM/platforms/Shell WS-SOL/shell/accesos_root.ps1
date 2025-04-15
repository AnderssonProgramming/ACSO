# Script para revisar intentos fallidos de acceso al usuario administrador
# Este script busca eventos de seguridad relacionados con intentos fallidos de inicio de sesión

# Limpiar pantalla
Clear-Host

Write-Host "==========================================================" 
Write-Host "    INTENTOS FALLIDOS DE ACCESO AL ADMINISTRADOR" 
Write-Host "==========================================================" 

# Definir la cantidad de días hacia atrás para buscar (por defecto, 30 días)
$DiasAtras = 30
$FechaInicio = (Get-Date).AddDays(-$DiasAtras)

Write-Host "Buscando intentos fallidos en los últimos $DiasAtras días..." -ForegroundColor Yellow

# Intentar obtener eventos del registro de seguridad
# EventID 4625 = Fallo de inicio de sesión
try {
    $Events = Get-WinEvent -FilterHashTable @{
        LogName = 'Security'
        ID = 4625
        StartTime = $FechaInicio
    } -ErrorAction Stop | Where-Object {
        $_.Properties[5].Value -eq "Administrator" -or
        $_.Properties[5].Value -eq "Administrador" -or
        $_.Properties[1].Value -eq "S-1-5-21-*-500"
    }

    if ($Events.Count -gt 0) {
        Write-Host "Se encontraron $($Events.Count) intentos fallidos de acceso para el administrador:" -ForegroundColor Cyan
        
        # Mostrar cada intento con fecha y hora
        foreach ($Event in $Events) {
            $FechaHora = $Event.TimeCreated.ToString("yyyy-MM-dd HH:mm:ss")
            $DireccionIP = $Event.Properties[19].Value
            $Razon = $Event.Properties[8].Value
            
            Write-Host "Fecha/Hora: $FechaHora - IP: $DireccionIP - Razón: $Razon" -ForegroundColor White
        }
        
        Write-Host "==========================================================" 
        Write-Host "Total de intentos fallidos de acceso para el administrador: $($Events.Count)" -ForegroundColor Green
        Write-Host "==========================================================" 
    }
    else {
        Write-Host "No se encontraron intentos fallidos de acceso para el administrador en los últimos $DiasAtras días." -ForegroundColor Green
    }
}
catch {
    Write-Host "Error al buscar en el registro de eventos: $_" -ForegroundColor Red
    Write-Host "Es posible que necesite ejecutar PowerShell como administrador para acceder al registro de seguridad." -ForegroundColor Yellow
    
    # Intentar buscar en el registro de aplicaciones como alternativa
    try {
        Write-Host "Intentando buscar en otros registros..." -ForegroundColor Yellow
        $Events = Get-WinEvent -FilterHashTable @{
            LogName = 'Application'
            StartTime = $FechaInicio
        } -ErrorAction Stop | Where-Object { $_.Message -match "administrator|administrador" -and $_.Message -match "fail|fallo" }
        
        if ($Events.Count -gt 0) {
            Write-Host "Se encontraron $($Events.Count) posibles referencias a intentos fallidos de acceso:" -ForegroundColor Cyan
            foreach ($Event in $Events) {
                Write-Host "Fecha/Hora: $($Event.TimeCreated) - ID: $($Event.Id) - Mensaje: $($Event.Message.Substring(0, [Math]::Min(100, $Event.Message.Length)))..." -ForegroundColor White
            }
        }
        else {
            Write-Host "No se encontraron referencias a intentos fallidos en otros registros." -ForegroundColor Yellow
        }
    }
    catch {
        Write-Host "No se pudo acceder a los registros alternativos: $_" -ForegroundColor Red
    }
}

exit 0