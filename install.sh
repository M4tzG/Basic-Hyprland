#!/bin/bash

sub_folder () {
    local origin=$1
    local dest=$2
    

    if [ -d "$origin" ]; then
        if [ -d "$dest" ]; then
            mv "$dest" "$backup_dir"
        fi

        cp -r "$origin" "$dest" && echo "Pasta $origin movida para $dest e substituída."
    else
        echo "Erro: $origin não é uma pasta."
    fi
}

# Função para mover e substituir arquivos
sub_file () {
    local origin=$1
    local dest=$2

    if [ -f "$origin" ]; then
        if [ -f "$dest" ]; then
            mv "$dest" "$backup_dir"
        fi

        cp -r "$origin" "$dest"
        echo "Arquivo $origin movido para $dest e substituído."
    else
        echo "Erro: $origin não é um arquivo."
    fi
}

origin_dir=".config"

dest_dir="$HOME/.config"
#dest_dir="testando"

if [ ! -d "$dest_dir" ]; then
    mkdir -p "$dest_dir"
fi

backup_dir="config_backup"

if [ -d "$origin_dir" ]; then
    mkdir -p "$backup_dir"
    
    for folder in "$origin_dir"/*; do
        if [ -d "$folder" ]; then
            folder_name=$(basename "$folder")
            dir_name="$dest_dir/$folder_name"
            sub_folder "$folder" "$dir_name"
        fi
    done
else
    echo "Erro: O diretório de origem $origem_dir não existe."
fi

sub_file ".bashrc" "$HOME/.bashrc"