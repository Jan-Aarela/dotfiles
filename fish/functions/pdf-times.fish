function pdf-times --description "Muunna PDF fontiksi Times New Roman (viivat korjattu)"
    if test (count $argv) -lt 1
        echo "Käyttö: pdf-times syöte.pdf [tuloste.pdf]"
        return 1
    end

    set -l input $argv[1]
    set -l output "times_$input"

    if test (count $argv) -ge 2
        set output $argv[2]
    end

    pdftotext -layout -enc UTF-8 "$input" - | tr -d '\f\r' | iconv -f UTF-8 -t UTF-8//IGNORE | awk 'BEGIN {
        print "<!DOCTYPE html><html><head><meta charset=\"UTF-8\"><style>"
        print "@page { size: A4; margin: 1.5cm; }"
        print "body { font-family: \"Times New Roman\", \"Liberation Serif\", serif; font-size: 10pt; white-space: pre; }"
        print "hr { border: none; border-top: 1px solid #000; margin: 4px 0; }"
        print "</style></head><body>"
    } 
    {
        # Jos rivi koostuu pelkästään viivoista (esim. --- tai ___), korvataan se HTML-viivalla
        if ($0 ~ /^[ \t]*[-_=+]{3,}[ \t]*$/) {
            print "<hr>"
        } else {
            print $0
        }
    } 
    END { print "</body></html>" }' | weasyprint - "$output"
end
