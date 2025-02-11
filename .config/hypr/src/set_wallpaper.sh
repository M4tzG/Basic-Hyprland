set_wallpaper() {

    INTERNAL_MONITOR="eDP"
	EXTERNAL_MONITOR="HDMI-A-1"

    WALLPAPER_DIR="$HOME/.config/hypr/themes/$THEME/wallps"

    WALLPAPER=$(find "$WALLPAPER_DIR" -type f | shuf -n 1)

    
    if [[ $(xrandr -q | grep "${EXTERNAL_MONITOR} connected") ]]; then
        hyprctl hyprpaper wallpaper "eDP-1,$WALLPAPER" 
        hyprctl hyprpaper wallpaper "HDMI-A-1,$WALLPAPER"
	else
        hyprctl hyprpaper wallpaper "eDP-1,$WALLPAPER"
	fi
}
