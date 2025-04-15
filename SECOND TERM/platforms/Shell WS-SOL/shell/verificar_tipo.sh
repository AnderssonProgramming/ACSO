#!/bin/sh
# Script para verificar si un elemento es un archivo, un subdirectorio u otra cosa
# Uso: ./verificar_tipo.sh nombre_elemento directorio_busqueda

# Verificar que se hayan proporcionado los dos parámetros
if [ $# -ne 2 ]; then
    echo "Error: Debe proporcionar dos parámetros."
    echo "Uso: $0 nombre_elemento directorio_busqueda"
    exit 1
fi

nombre="$1"
directorio="$2"

# Verificar si el directorio existe
if [ ! -d "$directorio" ]; then
    echo "Error: El directorio '$directorio' no existe."
    exit 1
fi

# Construir la ruta completa del elemento
ruta_completa="$directorio/$nombre"

# Verificar el tipo de elemento
if [ -f "$ruta_completa" ]; then
    echo "'$nombre' es un archivo en el directorio '$directorio'."
elif [ -d "$ruta_completa" ]; then
    echo "'$nombre' es un subdirectorio dentro de '$directorio'."
elif [ -e "$ruta_completa" ]; then
    echo "'$nombre' existe en '$directorio' pero no es un archivo ni un subdirectorio (podría ser un enlace simbólico, socket, etc.)."
else
    echo "'$nombre' no existe en el directorio '$directorio'."
fi

exit 0