#!/bin/bash
# Configuracion previo a instalacion de Oracle 12c R1

#Falta modificacion en archivos hosts y hostname

echo "CONFIGURANDO PARA INSTALACION ORACLE"

echo "-----------------------------------------"
echo ">> Actualizando hostname...";
echo "fedora25.localdomain" >> /etc/hostname
echo ""
cat /etc/hostname

echo "-----------------------------------------"
echo ">> Copiando parametros de kernel...";
cp 98-oracle.conf /etc/sysctl.d/;
#Actualizar los parametros:
echo ">> #/sbin/sysctl -p"
/sbin/sysctl -p;
echo ">> Parametros cargados:";
echo ""
cat /etc/sysctl.d/98-oracle.conf

echo ">> Deshabilitando Firewall...";
systemctl stop firewalld;
systemctl disable firewalld;
echo ">> Estado de firewall (presiona q para continuar si no se muestra el prompt): ";
systemctl status firewalld


echo "-----------------------------------------"
echo ">> Copiando parametros de Shell...";
echo ">> cp	oracle-rdbms-server-12cR1-preinstall.conf  /etc/security/limits.d/"
cp 	oracle-rdbms-server-12cR1-preinstall.conf  /etc/security/limits.d/
echo ">> Parametros cargados:";
echo ""
cat /etc/security/limits.d/oracle-rdbms-server-12cR1-preinstall.conf


echo "-----------------------------------------"

seLnxNewStatStr="SELINUX=permissive";
echo ">> Cambiando configuración de SELinux";
cat /etc/selinux/config | sed -e "s/SELINUX=enforcing/${seLnxNewStatStr}/g" >> output
#borrando archivo config anterior
rm /etc/selinux/config
rename -v output config /etc/selinux/output
echo ">> El estado de SELinux ahora es  "; sestatus

echo "-----------------------------------------"
echo ">> Instalando paquetes requeridos..."
echo ">> MATE Desktop";
dnf groupinstall "MATE Desktop" -y
echo ">> Development Tools";
dnf groupinstall "Development Tools" -y
echo ">> Administration Tools";
dnf groupinstall "Administration Tools" -y
echo ">> System Tools";
dnf groupinstall "System Tools" -y
echo ">> Firefox";
dnf install firefox -y

echo "-----------------------------------------"
echo ">> Instalando paquetes requeridos adicionales..."
dnf install binutils -y
dnf install compat-libstdc++-33 -y
dnf install compat-libstdc++-33.i686 -y
dnf install gcc -y
dnf install gcc-c++ -y
dnf install glibc -y
dnf install glibc.i686 -y
dnf install glibc-devel -y
dnf install glibc-devel.i686 -y
dnf install ksh -y
dnf install libgcc -y
dnf install libgcc.i686 -y
dnf install libstdc++ -y
dnf install libstdc++.i686 -y
dnf install libstdc++-devel -y
dnf install libstdc++-devel.i686 -y
dnf install libaio -y
dnf install libaio.i686 -y
dnf install libaio-devel -y
dnf install libaio-devel.i686 -y
dnf install libXext -y
dnf install libXext.i686 -y
dnf install libXtst -y
dnf install libXtst.i686 -y
dnf install libX11 -y
dnf install libX11.i686 -y
dnf install libXau -y
dnf install libXau.i686 -y
dnf install libxcb -y
dnf install libxcb.i686 -y
dnf install libXi -y
dnf install libXi.i686 -y
dnf install make -y
dnf install sysstat -y
dnf install unixODBC -y
dnf install unixODBC-devel -y
dnf install zlib-devel -y

echo "-----------------------------------------"
echo ">> Creando Grupos y usuario Oracle"
groupadd -g 54321 oinstall
groupadd -g 54322 dba
groupadd -g 54323 oper
groupadd -g 54324 backupdba
groupadd -g 54325 dgdba
groupadd -g 54326 kmdba
groupadd -g 54327 asmdba
groupadd -g 54328 asmoper
groupadd -g 54329 asmadmin

useradd -u 54321 -g oinstall -G dba,oper oracle
passwd oracle

echo "-----------------------------------------"
echo ">> Creando Carpetas de instalacíon de ORACLE"

mkdir -p /u01/app/oracle/product/12.1.0.2/db_1
chown -R oracle:oinstall /u01
chmod -R 775 /u01

echo "-----------------------------------------"
echo ">> Cambiando informacion de distribucion Fedora -> RedHat"
echo "redhat release 7" > /etc/redhat-release

echo ">> #cat /etc/redhat-release"
echo ""
cat /etc/redhat-release

echo "-----------------------------------------"
echo ">> Cambiando a Usuario Oracle... Para continuar ejecuta el script: LoadEnVar.sh. Bye guapa! :) "
su oracle


