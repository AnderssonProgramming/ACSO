#!/bin/sh
# Script para revisar intentos fallidos de acceso al usuario root
# Este script busca en los logs de autenticación y muestra fecha y hora de cada intento

# Limpiar pantalla
clear

echo "=========================================================="
echo "    INTENTOS FALLIDOS DE ACCESO AL USUARIO ROOT"
echo "=========================================================="

# En sistemas Solaris, los logs pueden estar en diferentes ubicaciones
# Verificamos las ubicaciones más comunes
log_files=("/var/log/auth.log" "/var/adm/messages" "/var/log/syslog")
contador=0

for log_file in "${log_files[@]}"; do
    if [ -f "$log_file" ]; then
        echo "Buscando en $log_file..."
        
        # Buscar patrones típicos de intentos fallidos de acceso para root
        # El comando awk se utiliza para extraer fecha y hora junto con el mensaje
        intentos=$(grep -i "Failed password" "$log_file" | grep -i "root" | awk '{print $1,$2,$3,$0}')
        
        if [ -n "$intentos" ]; then
            # Mostrar cada intento con fecha y hora
            echo "FECHA Y HORA                           MENSAJE"
            echo "-----------------------------------------------------------"
            echo "$intentos" | while read -r linea; do
                # Extraer fecha y hora (generalmente están en los primeros campos)
                fecha_hora=$(echo "$linea" | awk '{print $1" "$2" "$3}')
                mensaje=$(echo "$linea")
                echo "[$fecha_hora] - $mensaje"
            done
            
            # Contar el número de intentos encontrados
            num_intentos=$(echo "$intentos" | wc -l)
            contador=$((contador + num_intentos))
        fi
    fi
done

# Si no se encontraron logs en las ubicaciones estándar, buscar en /var/log
if [ $contador -eq 0 ]; then
    echo "Buscando en archivos de log adicionales..."
    
    # Buscar en todos los archivos de log
    for log_file in /var/log/*; do
        if [ -f "$log_file" ]; then
            intentos=$(grep -i "Failed password" "$log_file" | grep -i "root" | awk '{print $1,$2,$3,$0}')
            
            if [ -n "$intentos" ]; then
                echo "En $log_file:"
                echo "FECHA Y HORA                           MENSAJE"
                echo "-----------------------------------------------------------"
                echo "$intentos" | while read -r linea; do
                    # Extraer fecha y hora
                    fecha_hora=$(echo "$linea" | awk '{print $1" "$2" "$3}')
                    mensaje=$(echo "$linea")
                    echo "[$fecha_hora] - $mensaje"
                done
                
                # Contar el número de intentos encontrados
                num_intentos=$(echo "$intentos" | wc -l)
                contador=$((contador + num_intentos))
            fi
        fi
    done
fi

echo "=========================================================="
echo "Total de intentos fallidos de acceso para root: $contador"
echo "=========================================================="

exit 0