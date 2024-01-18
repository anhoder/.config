function _pwd
    set --local p (prompt_pwd)
    set --local p_color (set_color cyan)

    echo $p_color$p
end