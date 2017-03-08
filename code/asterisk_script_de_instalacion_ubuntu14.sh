#!/bin/bash
########################################################################################################################
# Archivo: ./asterisk_script_de_instalacion_ubuntu14.sh                                                                #
# Autor: Cristian Segura <cristian.segura.lepe@gmail.com>                                                              #
# Fecha Creación: 2017-02-19 22:14                                                                                     #
# Uso: Instalación de Asterisk IP PBX                                                                                  #
########################################################################################################################

# Referencias
# - Asterisk Wikipedia Entry; "Installing Asterisk from Source"
#   url: https://wiki.asterisk.org/wiki/display/AST/Installing+Asterisk+From+Source

# Versiones actuales de Asterisk a la fecha (2017-Feb-26)
# url: http://www.asterisk.org/downloads/asterisk/all-asterisk-versions
# ---------------------------------------------------------
# Release Series            Support Types   Release Frequency
# Asterisk 14               Standard	    6 - 8 Weeks
# Certified Asterisk 13	    LTS             2 - 4 times per year
# Asterisk 13	            LTS             6 - 8 Weeks
# Certified Asterisk 11     LTS             2 - 4 times per year
# Asterisk 11               LTS             6 - 8 Weeks
# ---------------------------------------------------------

#----------------------------------------------------------------------------------------------------------------------#
# CONSTANTES DEL SCRIPT                                                                                                #
#----------------------------------------------------------------------------------------------------------------------#
# URLs de descarga de Asterisk 13
BASE_URL='http://downloads.asterisk.org/pub/telephony'
ASTERISK_DIR='asterisk'
ASTERISK_ARCHIVE='asterisk-13-current.tar.gz'
DAHDI_DIR='dahdi-linux-complete'
DAHDI_ARCHIVE='dahdi-linux-complete.tar.gz'
LIBPRI_DIR='libpri'
LIBPRI_ARCHIVE='libpri-current.tar.gz'


TIMESTAMP=$(date +%Y-%m-%d_%H%M%S)
WORKDIR=${TIMESTAMP}_asterisk_sources

#----------------------------------------------------------------------------------------------------------------------#
# DEPENDENCIAS DEL SCRIPT                                                                                              #
#----------------------------------------------------------------------------------------------------------------------#
apt-get -y install wget    # wget: programa para descargar archivos via HTTP

########################################################################################################################
#                                                                                                                      #
# PASO 1: Descargar Código Fuente de Asterisk y Software Asociado                                                      #
#                                                                                                                      #
########################################################################################################################

# Crear directorio para descargar archivos
mkdir $WORKDIR
cd $WORKDIR
wget ${BASE_URL}/${ASTERISK_DIR}/${ASTERISK_ARCHIVE}
wget ${BASE_URL}/${DAHDI_DIR}/${DAHDI_ARCHIVE}
wget ${BASE_URL}/${LIBPRI_DIR}/${LIBPRI_ARCHIVE}


########################################################################################################################
#                                                                                                                      #
# PASO 2: Descomprimir el Código Fuente y Moverlo a directorio /usr/src                                                #
#                                                                                                                      #
########################################################################################################################


# Descomprimir archivos descargados
tar -xzvf ${ASTERISK_ARCHIVE}
tar -xzvf ${DAHDI_ARCHIVE}
tar -xzvf ${LIBPRI_ARCHIVE}
# Limpiar
rm -rf  ${ASTERISK_ARCHIVE}
rm -rf  ${DAHDI_ARCHIVE}
rm -rf  ${LIBPRI_ARCHIVE}
# Obtener el nombre de los directorio de Asterisk, Dahdi y LibPRI
asterisk_src_dir=$(ls | grep asterisk)
dahdi_src_dir=$(ls | grep dahdi)
libpri_src_dir=$(ls | grep libpri)
# Copiar código fuente a directorio /usr/src
cp -r $asterisk_src_dir  /usr/src
cp -r $dahdi_src_dir     /usr/src
cp -r $libpri_src_dir    /usr/src


########################################################################################################################
#                                                                                                                      #
# PASO 3: Instalar Dependencias de Compilación de Asterisk                                                             #
#                                                                                                                      #
########################################################################################################################

# <asterisk-sources-dir> $ ./configure

#------------------------------------------------------------------------
#ISSUE:
#
#checking for initscr in -lncurses... no
#configure: error: *** termcap support not found (on modern systems, this typically means the ncurses development package is missing)
#
#SOLUTION:
#   - Install ncurses source code
#csl@esclavo1:/usr/src/asterisk-13.14.0$ sudo apt-get install libncurses5-dev
#Reading package lists... Done
#Building dependency tree
#Reading state information... Done
#The following package was automatically installed and is no longer required:
#  linux-image-extra-4.4.0-59-generic
#Use 'apt-get autoremove' to remove it.
#The following extra packages will be installed:
#  libtinfo-dev
#Suggested packages:
#  ncurses-doc
#The following NEW packages will be installed:
#  libncurses5-dev libtinfo-dev
#0 upgraded, 2 newly installed, 0 to remove and 0 not upgraded.
#Need to get 246 kB of archives.
#After this operation, 1.479 kB of additional disk space will be used.
#Do you want to continue? [Y/n]
#
#------------------------------------------------------------------------
#ISSUE:
#
#checking for uuid_generate_random in -luuid... no
#checking for uuid_generate_random in -le2fs-uuid... no
#checking for uuid_generate_random... no
#configure: error: *** uuid support not found (this typically means the uuid development package is missing)
#
# SOLUTION:
#
#csl@esclavo1:/usr/src/asterisk-13.14.0$ sudo apt-get install uuid-dev
#Reading package lists... Done
#Building dependency tree
#Reading state information... Done
#The following package was automatically installed and is no longer required:
#  linux-image-extra-4.4.0-59-generic
#Use 'apt-get autoremove' to remove it.
#The following NEW packages will be installed:
#  uuid-dev
#0 upgraded, 1 newly installed, 0 to remove and 0 not upgraded.
#Need to get 23,7 kB of archives.
#After this operation, 158 kB of additional disk space will be used.

#------------------------------------------------------------------------
#ISSUE:
#
#checking for json_dumps in -ljansson... no
#configure: error: *** JSON support not found (this typically means the libjansson development package is missing)
#
# SOLUTION:
#
#csl@esclavo1:/usr/src/asterisk-13.14.0$ sudo apt-get install libjansson-dev
#Reading package lists... Done
#Building dependency tree
#Reading state information... Done
#The following package was automatically installed and is no longer required:
#  linux-image-extra-4.4.0-59-generic
#Use 'apt-get autoremove' to remove it.
#The following extra packages will be installed:
#  libjansson4
#The following NEW packages will be installed:
#  libjansson-dev libjansson4
#0 upgraded, 2 newly installed, 0 to remove and 0 not upgraded.
#Need to get 50,0 kB of archives.
#After this operation, 227 kB of additional disk space will be used.
#Do you want to continue? [Y/n] Y
#
#------------------------------------------------------------------------
#ISSUE:
#
#checking for xml2-config... no
#configure: *** The Asterisk menuselect tool requires the 'libxml2' development package.
#configure: *** Please install the 'libxml2' development package.
#
# SOLUTION:
#
#csl@esclavo1:/usr/src/asterisk-13.14.0$ sudo apt-get install libxml2-dev
#Reading package lists... Done
#Building dependency tree
#Reading state information... Done
#The following package was automatically installed and is no longer required:
#  linux-image-extra-4.4.0-59-generic
#Use 'apt-get autoremove' to remove it.
#The following NEW packages will be installed:
#  libxml2-dev
#0 upgraded, 1 newly installed, 0 to remove and 0 not upgraded.
#Need to get 631 kB of archives.
#After this operation, 2.932 kB of additional disk space will be used.
#

#------------------------------------------------------------------------
#ISSUE:
#
#checking for sqlite_exec in -lsqlite... no
#checking for sqlite3_open in -lsqlite3... no
#configure: error: *** Asterisk now uses SQLite3 for the internal Asterisk database.
#
# SOLUTION:
#
#csl@esclavo1:/usr/src/asterisk-13.14.0$ sudo apt-get install libsqlite3-dev
#Reading package lists... Done
#Building dependency tree
#Reading state information... Done
#The following package was automatically installed and is no longer required:
#  linux-image-extra-4.4.0-59-generic
#Use 'apt-get autoremove' to remove it.
#Suggested packages:
#  sqlite3-doc
#The following NEW packages will be installed:
#  libsqlite3-dev
#0 upgraded, 1 newly installed, 0 to remove and 0 not upgraded.
#Need to get 439 kB of archives.
#After this operation, 1.491 kB of additional disk space will be used.
#Get:1 http://mirror.uchile.cl/ubuntu/ trusty-updates/main libsqlite3-dev amd64 3.8.2-1ubuntu2.1 [439 kB]
#Fetched 439 kB in 0s (646 kB/s)
#Selecting previously unselected package libsqlite3-dev:amd64.
#(Reading database ... 518165 files and directories currently installed.)
#Preparing to unpack .../libsqlite3-dev_3.8.2-1ubuntu2.1_amd64.deb ...
#Unpacking libsqlite3-dev:amd64 (3.8.2-1ubuntu2.1) ...
#Setting up libsqlite3-dev:amd64 (3.8.2-1ubuntu2.1) ...
#


# script configure finaliza correctamente
#
#configure: Menuselect build configuration successfully completed
#
#               .$$$$$$$$$$$$$$$=..
#            .$7$7..          .7$$7:.
#          .$$:.                 ,$7.7
#        .$7.     7$$$$           .$$77
#     ..$$.       $$$$$            .$$$7
#    ..7$   .?.   $$$$$   .?.       7$$$.
#   $.$.   .$$$7. $$$$7 .7$$$.      .$$$.
# .777.   .$$$$$$77$$$77$$$$$7.      $$$,
# $$$~      .7$$$$$$$$$$$$$7.       .$$$.
#.$$7          .7$$$$$$$7:          ?$$$.
#$$$          ?7$$$$$$$$$$I        .$$$7
#$$$       .7$$$$$$$$$$$$$$$$      :$$$.
#$$$       $$$$$$7$$$$$$$$$$$$    .$$$.
#$$$        $$$   7$$$7  .$$$    .$$$.
#$$$$             $$$$7         .$$$.
#7$$$7            7$$$$        7$$$
# $$$$$                        $$$
#  $$$$7.                       $$  (TM)
#   $$$$$$$.           .7$$$$$$  $$
#     $$$$$$$$$$$$7$$$$$$$$$.$$$$$$
#       $$$$$$$$$$$$$$$$.
#
#configure: Package configured for:
#configure: OS type  : linux-gnu
#configure: Host CPU : x86_64
#configure: build-cpu:vendor:os: x86_64 : unknown : linux-gnu :
#configure: host-cpu:vendor:os: x86_64 : unknown : linux-gnu :
#

apt-get install -y libncurses5-dev # lib ncurses - interfaz grafica en modo texto (tui)
apt-get install -y uuid-dev        # lib uui - generador de nombre unicos
apt-get install -y libjansson-dev  # lib jansson - herramientas para json
apt-get install -y libxml2-dev     # lib xml2 - procesamiento de archivos xml2
apt-get install -y libsqlite3-dev  # lib sqlite3 - uso de base de datos sqlite3


########################################################################################################################
#                                                                                                                      #
# PASO 4: PROCESO DE COMPILACION                                                                                       #
#                                                                                                                      #
########################################################################################################################

#----------------------------------------------------------------------------------------------------------------------#
# - 4.1 Compilar DAHDI                                                                                                 #
#----------------------------------------------------------------------------------------------------------------------#

cd /usr/src/${dahdi_src_dir}  # Ir al directorio donde está el código fuente de DAHDI
make                          # Compilar ... crea binarios
make install                  # Mueve binarios a su ubicación correcta dentro del Sistema operativo
make config                   # Instalar scripts para controlar servicios y configura auto-arranque del servicio

#----------------------------------------------------------------------------------------------------------------------#
# - 4.2 Compilar LIBPRI                                                                                                #
#----------------------------------------------------------------------------------------------------------------------#

cd /usr/src/${libpri_src_dir}  # Ir al directorio donde está el código fuente de LIBPRI
make                           # Compilar ... crea binarios
make install                   # Mueve binarios a su ubicación correcta dentro del Sistema operativo


#----------------------------------------------------------------------------------------------------------------------#
# - 4.3 Compilar ASTERISK                                                                                              #
#----------------------------------------------------------------------------------------------------------------------#

cd /usr/src/${asterisk_src_dir}  # Ir al directorio donde está el código fuente de DAHDI
./configure                   # crea scripts de compilación de Asterisk
make                          # Compilar ... crea binarios
make install                  # Mueve binarios a su ubicación correcta dentro del Sistema operativo
make config                   # Instalar scripts para controlar servicios y configura auto-arranque del servicio


# +---- Asterisk Installation Complete -------+
# +                                           +
# +    YOU MUST READ THE SECURITY DOCUMENT    +
# +                                           +
# + Asterisk has successfully been installed. +
# + If you would like to install the sample   +
# + configuration files (overwriting any      +
# + existing config files), run:              +
# +                                           +
# + For generic reference documentation:      +
# +    make samples                           +
# +                                           +
# + For a sample basic PBX:                   +
# +    make basic-pbx                         +
# +                                           +
# +                                           +
# +-----------------  or ---------------------+
# +                                           +
# + You can go ahead and install the asterisk +
# + program documentation now or later run:   +
# +                                           +
# +               make progdocs               +
# +                                           +
# + **Note** This requires that you have      +
# + doxygen installed on your local system    +
# +-------------------------------------------+


