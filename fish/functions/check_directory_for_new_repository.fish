function check_directory_for_new_repository
    set current_repository (git rev-parse --show-toplevel 2> /dev/null)
    if [ "$current_repository" ] && [ "$current_repository" != "$last_repository" ]
        # onefetch --nerd-fonts
        bash ~/.config/scripts/onefetch.sh
    end
    set -gx last_repository $current_repository
end
