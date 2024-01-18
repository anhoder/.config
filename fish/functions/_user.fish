function _user
    set --local username $USER
    set --local username_color (set_color yellow)

    echo $username_color$username
end