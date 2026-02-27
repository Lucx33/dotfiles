#!/bin/bash

THEMES_DIR="$HOME/.config/themes"
CURRENT_FILE="$THEMES_DIR/.current"

# Lista temas disponíveis
AVAILABLE=$(ls -d "$THEMES_DIR"/*/  | xargs -n1 basename | grep -v "^$")

# Se não passar argumento, mostra uso
if [ -z "$1" ]; then
    CURRENT=$(cat "$CURRENT_FILE" 2>/dev/null || echo "nenhum")
    echo "Tema atual: $CURRENT"
    echo "Temas disponíveis: $(echo $AVAILABLE | tr '\n' ' ')"
    echo "Uso: switch.sh <tema>"
    exit 0
fi

THEME="$1"
THEME_DIR="$THEMES_DIR/$THEME"

if [ ! -d "$THEME_DIR" ]; then
    echo "Tema '$THEME' não encontrado."
    echo "Disponíveis: $AVAILABLE"
    exit 1
fi

echo "Aplicando tema: $THEME"

# Aplica waybar CSS
cp "$THEME_DIR/waybar.css" "$HOME/.config/waybar/style.css"

# Pega o wallpaper do tema
WALLPAPER=$(grep 'path' "$THEME_DIR/hyprpaper.conf" | awk '{print $3}')

# Salva configs
cp "$THEME_DIR/hyprpaper.conf" "$HOME/.config/hypr/hyprpaper.conf"
cp "$THEME_DIR/colors.conf" "$HOME/.config/hypr/theme-colors.conf"
echo "$THEME" > "$CURRENT_FILE"

# Troca wallpaper com transição fade suave via swww
swww img "$WALLPAPER" \
    --transition-type center \
    --transition-duration 1 \
    --transition-fps 60

# Aplica tema do kitty e recarrega (sem fechar janelas)
cp "$THEME_DIR/kitty.conf" "$HOME/.config/kitty/current-theme.conf"
kill -SIGUSR1 $(pgrep -x kitty) 2>/dev/null

# Aplica tema do fastfetch
cp "$THEME_DIR/fastfetch.jsonc" "$HOME/.config/fastfetch/config.jsonc"

# Aplica tema do rofi
cp "$THEME_DIR/rofi.rasi" "$HOME/.config/rofi/current-theme.rasi"

# Recarrega waybar (aguarda processo morrer antes de iniciar novo)
pkill waybar
while pgrep -x waybar > /dev/null; do sleep 0.1; done
waybar &

# Recarrega cores do hyprland
hyprctl reload

echo "Tema '$THEME' aplicado com sucesso!"
