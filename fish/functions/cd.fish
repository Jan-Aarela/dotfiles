function cd --wraps==cd
    builtin cd $argv || return
    check_directory_for_new_repository
end
