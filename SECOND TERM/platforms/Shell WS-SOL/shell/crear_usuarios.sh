#!/bin/sh

# Este script crea 5 usuarios de prueba con descripciones
# Nota: Debe ejecutarse con privilegios de superusuario (su)

# Verificar si se está ejecutando como root
if [ `/usr/bin/id -u` -ne 0 ]; then
    echo "Este script debe ejecutarse con privilegios de superusuario (su)"
    exit 1
fi

# Crear usuarios con descripciones
echo "Creando usuarios de prueba..."

# Usuario 1 - En Solaris se usa useradd con parámetros diferentes
/usr/sbin/useradd -c "Administrador del Sistema" -m -d /export/home/usuario_admin usuario_admin
echo "Usuario 'usuario_admin' creado con descripción 'Administrador del Sistema'"

# Usuario 2
/usr/sbin/useradd -c "Desarrollador Web" -m -d /export/home/usuario_dev usuario_dev
echo "Usuario 'usuario_dev' creado con descripción 'Desarrollador Web'"

# Usuario 3
/usr/sbin/useradd -c "Analista de Base de Datos" -m -d /export/home/usuario_dba usuario_dba
echo "Usuario 'usuario_dba' creado con descripción 'Analista de Base de Datos'"

# Usuario 4
/usr/sbin/useradd -c "Soporte Técnico" -m -d /export/home/usuario_soporte usuario_soporte
echo "Usuario 'usuario_soporte' creado con descripción 'Soporte Técnico'"

# Usuario 5
/usr/sbin/useradd -c "Estudiante de Prueba" -m -d /export/home/usuario_test usuario_test
echo "Usuario 'usuario_test' creado con descripción 'Estudiante de Prueba'"

echo "Todos los usuarios han sido creados correctamente."
echo "Puedes ejecutar 'grep usuario_ /etc/passwd' para verificarlos."

exit 0
