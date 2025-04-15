#!/bin/sh
# Script to search for a word in a specified file

# Clear the screen
clear

# Check if correct number of parameters were provided
if [ $# -ne 2 ]; then
    echo "Error: Se requieren dos parámetros."
    echo "Uso: ./buscar_palabra.sh <palabra_buscada> <archivo_de_busqueda>"
    exit 1
fi

# Get parameters
palabra="$1"
archivo="$2"

# Check if the file exists
if [ ! -f "$archivo" ]; then
    echo "Error: El archivo '$archivo' no existe."
    exit 1
fi

# Search for the word in the file
echo "Buscando '$palabra' en el archivo '$archivo':"
echo "----------------------------------------"

# Using grep to find matching lines
resultados=$(grep -i "$palabra" "$archivo")
if [ -n "$resultados" ]; then
    echo "$resultados"
    echo "----------------------------------------"
    coincidencias=$(grep -i -c "$palabra" "$archivo")
    echo "Se encontraron $coincidencias coincidencias."
else
    echo "No se encontraron coincidencias para '$palabra'."
fi