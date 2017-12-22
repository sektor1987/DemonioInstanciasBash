#!/bin/bash 

SCRIPT_FULLNAME=`/usr/bin/readlink -e $0`
SCRIPT_DIRECTORIO=`/usr/bin/dirname $SCRIPT_FULLNAME`
SCRIPT_NOMBRE=`/bin/basename $SCRIPT_FULLNAME`
APP_BASEDIR=${SCRIPT_DIRECTORIO%/scripts}

ps -ef | grep "$SCRIPT_NOMBRE" | grep -v "grep" | grep "/bin/bash" | wc -l > $SCRIPT_FULLNAME.instances
NUMERO_INSTANCIAS=$(cat $SCRIPT_FULLNAME.instances)
rm -f  $SCRIPT_FULLNAME.instances 

if [ $NUMERO_INSTANCIAS -le 1 ]; then
    
    while [ ! -f "$SCRIPT_FULLNAME.stop" ]
    do
        date > $SCRIPT_DIRECTORIO/lastrun/$SCRIPT_NOMBRE.lastrun
        # --- Inicio Modulo Variable del Procesador de Demonios ---
        
        cd $SCRIPT_DIRECTORIO
        perl tesst1.pl

        cd $SCRIPT_DIRECTORIO
        perl tesst2.pl
        
		cd $SCRIPT_DIRECTORIO
        perl tesst3.pl
        # --- Fin Modulo Variable del Procesador de Demonios ---
        sleep 1
        
    done
    
else
    echo "Imposible ejecutar $SCRIPT_NOMBRE. Demasiadas instancias activas ($NUMERO_INSTANCIAS) "
fi

