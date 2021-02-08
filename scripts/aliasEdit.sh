#! /bin/bash
# Allows user to add or remove aliases on the fly 

function mkAlias() {
         if (("$#" < 2));
         then
                echo "mkAlias alias_name 'command' to alias";
         else
                 local abbr="$1"
                 local cmd="$2"
                 local cmd1= "$(echo "$cmd" | awk '{print $1}')"
                 if hash $cmd1 2> /dev/null;
                 then
                     local str="alias ${abbr}=\"$cmd\""
                     echo "$str" >> ~/.bash_aliases
                     source ~/.bashrc
                 else
                     echo "Bad command"
                 fi
         fi
}
 
function rmAlias() {
    local cmd="$1"
    echo $cmd
    sed "/^alias $cmd/d" ~/.bash_aliases > ~/.bash_aliasesn
    mv ~/.bash_aliasesn ~/.bash_aliases
    source ~/.bashrc
}
