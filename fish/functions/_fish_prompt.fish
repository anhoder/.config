function fish_prompt
    set -g exit_code $status

    echo ''
    printf '%s %s@ %s %s %s\n' (_user) (set_color grey) (_pwd) (_git) (_last_code)
    if test "$exit_code" != 0
        set_color red
    else
        set_color green 
    end
    echo '# '(set_color normal) 
end
