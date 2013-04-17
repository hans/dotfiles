(when (require 'emms-setup nil t)
  (emms-standard)

  (require 'emms-player-mpd)

  (setq emms-player-mpd-server-name "localhost"
        emms-player-mpd-server-port "6600")

  (add-to-list 'emms-info-functions 'emms-info-mpd)
  (add-to-list 'emms-player-list 'emms-player-mpd))
