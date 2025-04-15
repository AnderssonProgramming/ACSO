#!/bin/sh

# Definir el archivo de salida
ARCHIVO_SALIDA="usuariosS_descripcion.txt"

# Limpiar el archivo de salida si ya existe
> "$ARCHIVO_SALIDA"

# Extraer nombres de usuario y descripciones del archivo /etc/passwd
echo "Extrayendo nombres de usuario y descripciones..."
echo "================================================" >> "$ARCHIVO_SALIDA"
echo "USUARIO | DESCRIPCIÓN" >> "$ARCHIVO_SALIDA"
echo "================================================" >> "$ARCHIVO_SALIDA"

# En Solaris, usamos comandos específicos del sistema
# El campo GECOS está en la quinta columna del archivo passwd
/usr/bin/cut -d: -f1,5 /etc/passwd | while read linea
do
    # Separar el nombre de usuario y la descripción usando cut de Solaris
    USUARIO=`echo "$linea" | /usr/bin/cut -d: -f1`
    DESCRIPCION=`echo "$linea" | /usr/bin/cut -d: -f2`
    
    # Solo incluir entradas que tengan una descripción
    if [ ! -z "$DESCRIPCION" ]; then
        echo "$USUARIO | $DESCRIPCION" >> "$ARCHIVO_SALIDA"
    fi
done

echo "La información ha sido guardada en $ARCHIVO_SALIDA"
echo "Contenido del archivo de salida:"
echo "--------------------------------"
/usr/bin/cat "$ARCHIVO_SALIDA"
