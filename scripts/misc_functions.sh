# Function instead of Alias to launch PDF documents
function rdpdf() {
    evince -I "$*" &
}

# Function to help navigate personal documents easily 
function sem() {
    local num="$1"
    local link="$HOME/Documents/books/SEM-${num}"
    cd "$link"
}

# Automates compilation of LaTeX and forces live-update using SIGHUP
function tex-compile() {
    pdflatex "$1"
    bibtex "$(echo $1 | sed 's/tex$/aux/')"
    pdflatex "$1"
    pdflatex "$1"

    regex=$(echo "$1" | sed 's/tex$/pdf$/')
    pids=( $(ps aux | grep "$regex" | awk '{print $2}') )
    
    if [ ${#pids[@]} -eq 0 ]; 
    then
        mupdf $(echo "$1" | sed 's/tex$/pdf/') &        
    else 
        for element in "${pids[@]}"
        do
            kill -SIGHUP $element
        done
    fi
}
