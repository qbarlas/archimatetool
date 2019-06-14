#!/bin/sh
Xvfb $DISPLAY &

rm -rf /output/report && mkdir -p /output/report
/opt/Archi/Archi -application com.archimatetool.commandline.app -consoleLog -nosplash $@