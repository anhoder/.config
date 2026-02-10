function __fish_brew_switch_need_package
    test (count (commandline -opc)) -le 1
end

function __fish_brew_switch_needs_version
    set -l tokens (commandline -opc)
    test (count $tokens) -eq 2
end

function __fish_brew_switch_packages
    brew list --formula | string replace -r '@.*$' '' | sort -u
end

function __fish_brew_switch_versions
    set -l tokens (commandline -opc)
    set -l pkg $tokens[2]
    if test -z "$pkg"
        return
    end

    set -l versioned (brew list --formula | string match -r "^$pkg@.+")
    set -l versions
    for formula in $versioned
        set versions $versions (string replace -r "^$pkg@" '' $formula)
    end

    printf "%s\n" (printf "%s\n" latest $versions | sort -u)
end

complete -c brew_switch -f -n "__fish_brew_switch_need_package" -a "(__fish_brew_switch_packages)" -d "Installed formula"
complete -c brew_switch -f -n "__fish_brew_switch_needs_version" -a "(__fish_brew_switch_versions)" -d "Version or 'latest'"
