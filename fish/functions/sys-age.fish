function sys-age
    set -l raw_birth (stat / | grep -i "birth" | awk '{print $2, $3}')
    set -l clean_birth (string split -f1 '.' $raw_birth)

    set -l birth_seconds (date -d "$clean_birth" +%s)
    set -l now_seconds (date +%s)
    set -l diff_seconds (math $now_seconds - $birth_seconds)

    set -l years (math --scale=0 "$diff_seconds / 31536000")
    set -l days (math --scale=0 "($diff_seconds % 31536000) / 86400")
    set -l hours (math --scale=0 "($diff_seconds % 86400) / 3600")
    set -l minutes (math --scale=0 "($diff_seconds % 3600) / 60")
    set -l seconds (math "($diff_seconds % 60)")

    set -l birth (stat / | grep -i "birth" | xargs)
    echo $birth
    echo -e "Age:   $years years, $days days, $hours hours, $minutes minutes, $seconds seconds"

end
