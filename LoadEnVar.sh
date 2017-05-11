#!/bin/bash
# Configuracion previo a instalacion de Oracle 12c R1

echo "Cargando Variables de Entorno para usuario ORACLE..."
echo ">> #cat oracleSettings >> /home/oracle/.bash_profile"
cat oracleSettings >> /home/oracle/.bash_profile
echo ">> cat /home/oracle/.bash_profile"
cat /home/oracle/.bash_profile

echo ">> Cambando valor de DISPLAY... (DISPLAY=localhost:0.0)"
DISPLAY=localhost:0.0; 
export DISPLAY
echo ">> Valor de DISPLAY:"; $DISPLAY

echo "Si todo salio bien, ya puedes comenzar con la instalacion."
echo "Ejecuta ./runInstaller desde la carpeta /database"


