function _last_code
    set --local last_code ''
    set --local code_color ''

    if test "$exit_code" != 0
        set last_code "[$exit_code]"
        set code_color (set_color red)
    end

    echo $code_color$last_code
end