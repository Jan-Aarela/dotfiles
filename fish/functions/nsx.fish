# vim:foldmethod=marker

function nsx
    if test (count $argv) -gt 1
        nsxiv -to -g 1500x1000 $argv[1..-1]
    else if test (count $argv) -eq 1
        nsxiv -g 1500x1000 $argv[1]
    else
        nsxiv -to -g 1500x1000 *
    end
end
