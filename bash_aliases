
# la rerenfencia a los proyectos de python
alias pyclean='find . -name "*.pyc" -exec rm -rf {} \; && find . -name "*.so" -exec rm -rf {} \; && find . -name "*.c" -exec rm -rf {} \; && find . -name "*.pyo" -exec rm -rf {} \; && rm -rf build dist *.egg-info'

alias disable-touchpad="xinput | grep -i 'optical mouse ' && xinput | grep -i 'Synaptics TouchPad' && xinput set-prop 'SynPS/2 Synaptics TouchPad' 'Device Enabled' 0"
# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'
alias background-color-reset="xtermcontrol --bg '#000000'"
alias fix-touchpad='sudo modprobe -r psmouse && sudo modprobe psmouse'

export ENTRENAMIENTO_CONFIGURATION='/home/tzulberti/.entrenamiento-configuration.py'

export PYTEST_ADDOPTS='--tb=native'

# para que siempre use vim para todo lo que sea posible
export EDITOR=vim


# todo lo relacionado con el trabajo 
if [ -f ~/.bash_aliases_trabajo ]; then
    . ~/.bash_aliases_trabajo
fi
