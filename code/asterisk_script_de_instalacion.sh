#!/bin/bash
########################################################################################################################
# Archivo: ./asterisk_script_de_instalacion.sh                                                                         #
# Autor: Cristian Segura <cristian.segura.lepe@gmail.com>                                                              #
# Fecha Creación: 2017-02-19 22:14                                                                                     #
# Uso: Instalación de Asterisk IP PBX                                                                                  #
########################################################################################################################
#

#----------------------------------------------------------------------------------------------------------------------#
# CONSTANTES DEL SCRIPT                                                                                                #
#----------------------------------------------------------------------------------------------------------------------#
# URLs de descarga de Asterisk 13
BASE_URL='http://downloads.asterisk.org/pub/telephony'
ASTERISK_URL='asterisk/asterisk-13-current.tar.gz'
DAHDI_URL='dahdi/dahdi-linux-complete.tar.gz'
LIBPRI_URL='libpri/libpri-current.tar.gz'
#
TIMESTAMP=$(date +%Y-%m-%d_%H%M%S)
WORKDIR=${TIMESTAMP}_asterisk_sources

#----------------------------------------------------------------------------------------------------------------------#
# DEPENDENCIAS DEL SCRIPT                                                                                              #
#----------------------------------------------------------------------------------------------------------------------#
# sudo apt-get -y install wget    # wget: programa para descargar archivos via HTTP

# Crear directorio para descargar archivos
mkdir $WORKDIR
cd $WORKDIR

#----------------------------------------------------------------------------------------------------------------------#
# PASO 1: Descargar Código Fuente de Asterisk y Software Asociado                                                      #
#----------------------------------------------------------------------------------------------------------------------#
wget ${BASE_URL}/${ASTERISK_URL}




