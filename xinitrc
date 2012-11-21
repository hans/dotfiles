# Load .Xresources
[[ -f ~/.Xresources ]] && xrdb -merge ~/.Xresources

# Colemak
setxkbmap us && xmodmap .colemak/xmodmap/xmodmap.colemak && xset r 66

# Normal pointer
xsetroot -cursor_name left_ptr

# Non-retina-burning backlight setting (MacBook)
xbacklight -set 20

# Xmonad
exec ck-launch-session xmonad

# Background
feh --bg-scale ~/Pictures/backgrounds/arch_simple.png
