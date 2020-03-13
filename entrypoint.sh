#!/bin/sh
Xvfb $DISPLAY &

/opt/Archi/Archi -application com.archimatetool.commandline.app -consoleLog -nosplash $@