#
# Executes commands at logout.
# do not source prezto logut since it prints unwanted shit
# when leaving the console clear the screen to increase privacy

if [ "$SHLVL" = 1 ]; then
    [ -x /usr/bin/clear_console ] && /usr/bin/clear_console -q
fi
