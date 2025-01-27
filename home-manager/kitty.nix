{ pkgs, ... }:

{

    # Enable and Configure Kitty
    programs.kitty = {
        enable = true;
    
        # Font settings
        settings = {
            family = "JetBrains Mono";
            font_size = 14.5;
            
            bold_font = "auto";
            italic_font = "auto";
            bold_italic_font = "auto";
            
            # Window settings
            window_padding_width = 15;

            include = "~/.config/kitty/theme.conf"; 
            #background_opacity 0.6
            #hide_window_decorations yes 
            #confirm_os_window_close 0

        };
    };
  }
