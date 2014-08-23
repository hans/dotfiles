if ! [ -e "/Users" ]; then
    # Load .Xresources
    [[ -f ~/.Xresources ]] && xrdb -merge ~/.Xresources

    # Clipboard
    autocutsel -fork &
    autocutsel -selection PRIMARY -fork &

    # Colemak
    setxkbmap us && xmodmap ~/.colemak/xmodmap/xmodmap.colemak && xset r 66

    # Normal pointer
    xsetroot -cursor_name left_ptr

    # Non-retina-burning backlight setting (MacBook)
    xbacklight -set 15

    # Xmonad
    exec xmonad
fi
