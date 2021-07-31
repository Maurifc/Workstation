# Fix resolução do segundo monitor
# Usar o comando 'cvt RESOLUCAO_X RESOLUCAO_Y' para gerar os parâmetros do novo modo

#!/bin/bash
sleep 5
#cvt 1280 1024 
xrandr --newmode "1280x1024_60.00"  109.00  1280 1368 1496 1712  1024 1027 1034 1063 -hsync +vsync
xrandr --addmode VGA-1 1280x1024_60.00 
xrandr --output VGA-1 --mode 1280x1024_60.00

