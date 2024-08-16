read -r THEME < "$HOME"/.config/hypr/.theme

source "$HOME"/.config/hypr/themes/"$THEME"/theme.conf
source "$HOME"/.config/hypr/src/set_term_config.sh
source "$HOME"/.config/hypr/src/set_wallpaper.sh
source "$HOME"/.config/hypr/src/set_fetch.sh

# =========================================================================== #

set_term_config
set_wallpaper
set_fetch

clear 
fastfetch

