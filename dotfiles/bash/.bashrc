if [ -f ~/.bash_aliases ]; then
    .    ~/.bash_aliases;
fi

function rdpdf() {
    evince "$*" &
}

function sem() {
    local num="$1"
    local link="$HOME/Documents/books/SEM-${num}"
    cd "$link"
}

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

shopt -s autocd
export PS1="\u@\H \w:-\[$(tput sgr0)\]"
export -f tex-compile

(cat ~/.cache/wal/sequences &)
source ~/.cache/wal/colors-tty.sh
source ~/.alEdit.sh
clear

# Created by `userpath` on 2020-02-01 06:38:23
export PATH="$PATH:/home/anjan/.local/bin"


export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"
