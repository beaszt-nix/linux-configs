if [ -f ~/.bash_aliases ]; then
    .    ~/.bash_aliases;
fi

set -o vi

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
export PS1="\u@\h \W: \[$(tput sgr0)\]"
export -f tex-compile

(cat ~/.cache/wal/sequences &)
source ~/.cache/wal/colors-tty.sh
source ~/.alEdit.sh
clear

# Created by `userpath` on 2020-02-01 06:38:23
export PATH="$PATH:/home/anjan/.local/bin"
export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"
export EDITOR=/usr/bin/nvim
export TERM='xterm-256color'

source /usr/share/fzf/completion.bash && source /usr/share/fzf/key-bindings.bash
complete -o bashdefault -o default -F _fzf_path_completion zathura
