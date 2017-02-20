#!/bin/bash
########################################################################################################################
# Archivo: ./asterisk_script_de_instalacion.sh                                                                         #
# Autor: Cristian Segura <cristian.segura.lepe@gmail.com>                                                              #
# Fecha Creación: 2017-02-19 22:14                                                                                     #
# Uso: Instalación de Asterisk IP PBX                                                                                  #
########################################################################################################################

#----------------------------------------------------------------------------------------------------------------------#
# CONSTANTES DEL SCRIPT                                                                                                #
#----------------------------------------------------------------------------------------------------------------------#
# URLs de descarga de Asterisk 13
BASE_URL='http://downloads.asterisk.org/pub/telephony'
ASTERISK_DIR='asterisk'
ASTERISK_ARCHIVE='asterisk-13-current.tar.gz'
DAHDI_URL='dahdi-linux-complete'
DAHDI_ARCHIVE='dahdi-linux-complete.tar.gz'
LIBPRI_DIR='libpri'
LIBPRI_ARCHIVE='libpri-current.tar.gz'

#
TIMESTAMP=$(date +%Y-%m-%d_%H%M%S)
WORKDIR=${TIMESTAMP}_asterisk_sources

#----------------------------------------------------------------------------------------------------------------------#
# DEPENDENCIAS DEL SCRIPT                                                                                              #
#----------------------------------------------------------------------------------------------------------------------#
apt-get -y install wget    # wget: programa para descargar archivos via HTTP


#----------------------------------------------------------------------------------------------------------------------#
# PASO 1: Descargar Código Fuente de Asterisk y Software Asociado                                                      #
#----------------------------------------------------------------------------------------------------------------------#
# Crear directorio para descargar archivos
mkdir $WORKDIR
cd $WORKDIR
wget ${BASE_URL}/${ASTERISK_DIR}/${ASTERISK_ARCHIVE}
wget ${BASE_URL}/${DAHDI_DIR}/${DAHDI_ARCHIVE}
wget ${BASE_URL}/${LIBPRI_DIR}/${LIBPRI_ARCHIVE}

#----------------------------------------------------------------------------------------------------------------------#
# PASO 2: Descomprimir el Código Fuente y Moverlo a directorio /usr/src                                                #
#----------------------------------------------------------------------------------------------------------------------#
tar -xzvf ${ASTERISK_ARCHIVE}
tar -xzvf ${DAHDI_ARCHIVE}
tar -xzvf ${LIBPRI_ARCHIVE}

rm -rf  ${ASTERISK_ARCHIVE}
rm -rf  ${DAHDI_ARCHIVE}
rm -rf  ${LIBPRI_ARCHIVE}

asterisk_src_dir=$(ls | grep asterisk)
dahdi_src_dir=$(ls | grep dahdi)
libpri_src_dir=$(ls | grep libpri)

cp -r $asterisk_src_dir  /usr/src
cp -r $dahdi_src_dir     /usr/src
cp -r $libpri_src_dir    /usr/src

#----------------------------------------------------------------------------------------------------------------------#
# PASO 3: Instalar Dependencias de Compilación de Asterisk                                                             #
#----------------------------------------------------------------------------------------------------------------------#



#----------------------------------------------------------------------------------------------------------------------#
# PASO 4: Descomprimir el Código Fuente y Moverlo a directorio /usr/src                                                #
#----------------------------------------------------------------------------------------------------------------------#








