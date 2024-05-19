# Open any given document file(s) for editing (or just viewing).
# Note1:
#    - Do not use for executable files!
# Note2:
#    - Uses 'mime' bindings, so you may need to use
#      e.g. a file manager to make proper file bindings.

openall() {
    if [ -x /usr/bin/xdg-open ] ; then
        for file in "$@" ; do
            echo "xdg-open $file" >&2
            setsid xdg-open "$file" >& /dev/null
        done
        return
    fi

    echo "$FUNCNAME: package 'xdg-utils' or 'exo' is required." >&2
}

# This should update the title on Kitty and similar terminals (e.g Foot)
function preexec {
    print -Pn "\e]0;${(q)1}\e\\"
}