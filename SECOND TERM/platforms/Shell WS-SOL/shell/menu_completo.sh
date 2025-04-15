#!/bin/sh
# Menu program for Solaris Unix Shell
# This script displays a menu and executes the selected previous exercises

while true; do
    # Clear the screen
    clear
    
    # Display the menu
    echo "===========================================" 
    echo "    MENU DE PROGRAMAS SHELL - SOLARIS"
    echo "===========================================" 
    echo "1. Hello World"
    echo "2. Número de líneas en /etc/profile"
    echo "3. Buscar palabra en archivo"
    echo "4. Extraer usuarios y descripción"
    echo "5. Buscar archivos con permisos específicos"
    echo "6. Verificar tipo de archivo"
    echo "7. Mostrar accesos root"
    echo "8. Terminar"
    echo "===========================================" 
    echo -n "Seleccione una opción (1-8): "
    
    # Read user input
    read option
    
    # Process the selected option using case statement
    case $option in
        1)
            echo "Ejecutando programa Hello World..."
            # Suponiendo que el script se llama hello_world.sh
            ./hello.sh
            read -p "Presione Enter para continuar..."
            ;;
        2)
            echo "Ejecutando programa de conteo de líneas..."
            # Suponiendo que el script se llama contar_lineas.sh
            ./count_lines.sh
            read -p "Presione Enter para continuar..."
            ;;
        3)
            echo "Ejecutando programa de búsqueda de palabras..."
            echo -n "Ingrese la palabra a buscar: "
            read palabra
            echo -n "Ingrese el archivo donde buscar: "
            read archivo
            # Suponiendo que el script se llama buscar_palabra.sh
            ./buscar_palabra.sh "$palabra" "$archivo"
            read -p "Presione Enter para continuar..."
            ;;
        4)
            echo "Ejecutando programa de extracción de usuarios..."
            # Suponiendo que el script se llama extraer_usuarios.sh
            ./extraer_usuarios.sh
            read -p "Presione Enter para continuar..."
            ;;
        5)
            echo "Ejecutando programa de búsqueda de archivos por permisos..."
            echo -n "Ingrese el directorio donde buscar: "
            read directorio
            echo -n "Ingrese los permisos a buscar (formato -rw-r--r--): "
            read permisos
            # Suponiendo que el script se llama buscar_archivos.sh
            ./buscar_archivos.sh "$directorio" "$permisos"
            read -p "Presione Enter para continuar..."
            ;;
        6)
            echo "Ejecutando programa para verificar tipo de archivo..."
            echo -n "Ingrese la ruta del archivo a verificar: "
            read ruta_archivo
            # Suponiendo que el script se llama verificar_tipo.sh
            ./verificar_tipo.sh "$ruta_archivo"
            read -p "Presione Enter para continuar..."
            ;;
        7)
            echo "Ejecutando programa para mostrar accesos root..."
            # Suponiendo que el script se llama accesos_root.sh
            ./accesos_root.sh
            read -p "Presione Enter para continuar..."
            ;;
        8)
            echo "Saliendo del programa. ¡Hasta luego!"
            exit 0
            ;;
        *)
            echo "Opción inválida. Por favor, seleccione una opción válida (1-8)."
            read -p "Presione Enter para continuar..."
            ;;
    esac
done