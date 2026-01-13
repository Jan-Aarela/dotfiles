# vim:foldmethod=marker

function bat
    if test (count $argv) -eq 0
        echo "No args."
    else
        /bin/bat --theme="Catppuccin Mocha" $argv[1]
    end
end
