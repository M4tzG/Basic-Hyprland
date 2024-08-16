set_wallpaper() {

    WALLPAPER_DIR="$HOME/.config/hypr/themes/$THEME/wallps"

    WALLPAPER=$(find "$WALLPAPER_DIR" -type f | shuf -n 1)

    hyprctl hyprpaper wallpaper "eDP-1,$WALLPAPER"
}
