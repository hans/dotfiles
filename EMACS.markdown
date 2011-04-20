# Emacs

I obsessively configure, and optimize my Emacs installation. This documentation gives a brief overview of the features my configuration adds, plus a quick cheat sheet for keyboard shortcuts.

A lot of this config originated from [Ryan McGeary (rmm5t)'s dotfiles][1].

  [1]: https://github.com/rmm5t/dotfiles

## Features

Customizations:

- Lots of easier keybindings @ `scripts/bindings.el` (see the cheat sheet for more)
- Simplifications of the Emacs interface @ `scripts/global.el`

Extra major modes:

- CoffeeScript
- Haskell
- Markdown
- PHP
- YAML

Color themes:

- Railscasts
- Solarized (default)
- Twilight

Significant other modes:

- ido
- ERC, an Emacs IRC client
  + Some custom configuration included: Auto-filling of screen, Growl / libnotify notifications when your username is mentioned
- YASnippet
- Magit

## Cheat sheet

Unfinished!

### Windows

<pre>
C-kp 2  Shrink the current window vertically
C-kp 8  Grow the current window vertically
C-kp 4  Shrink the current window horizontally
C-kp 6  Grow the current window horizontally
M-0     Delete the current window
M-1     Delete all but the current window
M-2     Split the current window vertically
M-3     Split the current window horizontally
M-o     Cycle through the open windows
</pre>

### Buffers

<pre>
M-k  Kill the current buffer
</pre>
