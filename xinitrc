# Load .Xresources
[[ -f ~/.Xresources ]] && xrdb -merge ~/.Xresources

# Colemak
setxkbmap us && xmodmap .colemak/xmodmap/xmodmap.colemak && xset r 66

# Normal pointer
xsetroot -cursor_name left_ptr

# Non-retina-burning backlight setting (MacBook)
xbacklight -set 15

# Xmonad
exec xmonad

# Background
feh --bg-scale ~/Pictures/background/clojure.jpeg
