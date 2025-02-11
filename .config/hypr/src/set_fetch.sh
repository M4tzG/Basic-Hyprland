
set_fetch() {

    LOGO_DIR="$HOME/.config/hypr/themes/$THEME/logo"

    # Escolhe um wallpaper aleatório
    LOGO=$(find "$LOGO_DIR" -type f | shuf -n 1)

    # Obtém a extensão do arquivo
    EXTENSION="${LOGO##*.}"

    # Define o tipo com base na extensão
    if [ "$EXTENSION" = "txt" ]; then
        LOGO_TYPE="file"
    elif [ "$EXTENSION" = "png" ]; then
        LOGO_TYPE="kitty-direct"
    else
        LOGO_TYPE="kitty-direct"  # Ou qualquer outro tipo padrão
    fi

    # Cria o arquivo de configuração
    cat >"$HOME/.config/fastfetch/config.jsonc" <<EOF
{
    "logo": {
        "type": "$LOGO_TYPE",
        "source": "${LOGO}",

        "padding": {
            "top": 2,
            "right": 1,
            "bottom": 0,
            "left": 2
        }
    },
    "display": {
        "separator": "  "
    },
    "modules": [

        {
            "type": "title",
            "key": "          "
        },
        {
            "type": "DateTime",
            "key": "         "
        },
        {
            "type": "custom",
            "format": "《·───────────────·》◈《·──────────────·》"
        },

        {
            "type": "os",
            "key": "    OS",
            "keyColor": "red"
        },
        {
            "type": "kernel",
            "key": "    Kernel",
            "keyColor": "red"
        },
        {
            "type": "packages",
            "key": "    Packages",
            "keyColor": "red"
        },

        "break",

        {
            "type": "wm",
            "key": "    WM",
            "keyColor": "blue"
        },
        {
            "type": "terminal",
            "key": "    Terminal",
            "keyColor": "blue"
        },

        {
            "type": "shell",
            "key": "    Shell",
            "keyColor": "blue"
        },

        "break",

        {
            "type": "display",
            "key": "    Display",
            "keyColor": "green"
        },
        {
            "type": "cpu",
            "format": "{1}",
            "key": "    CPU",
            "keyColor": "green"
        },
        {
            "type": "gpu",
            "format": "{2}",
            "key": "    GPU",
            "keyColor": "green"
        },
        {
            "type": "gpu",
            "format": "{3}",
            "key": "    GPU Driver",
            "keyColor": "green"
        },
        {
             "type": "memory",
            "key": "    Memory",
            "keyColor": "green"
        },

        "break",

        {
            "type": "uptime",
            "key": "    Uptime ",
            "keyColor": "yellow"
        },
        {
            "type": "Battery",
            "key": "    Battery ",
            "keyColor": "yellow"
        },
        {
            "type": "custom",
            "format": "《·───────────────·》◈《·──────────────·》"
        },
	{
            "type": "colors",
            "paddingLeft": 3,
            "symbol": "circle"
        },
        "break"

    ]
}

EOF
}
