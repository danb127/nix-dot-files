{ pkgs, ... }:

{

    # Zsh configuration
    programs.zsh = {
        enable = true;
        enableCompletion = true;
        autosuggestion.enable = true;
        syntaxHighlighting.enable = true;

        # initExtra is for extra commands added to .zshrc
        initExtra = "
        source ~/.p10k.zsh
        wal -R
        neofetch
        ";

        # Use initExtraFirst to add commands to the top of .zshrc
        initExtraFirst = ''
          # Instant prompt initialization
          if [[ -r "${pkgs.zsh-powerlevel10k}/share/instant-prompt/init.zsh" ]]; then
            source "${pkgs.zsh-powerlevel10k}/share/instant-prompt/init.zsh"
          fi
        '';

    

        # Aliases
        shellAliases = {
            ll = "ls -l";
            la = "ls -la";
            l = "ls";
            c = "clear";
            h = "history";
            e = "exit";
            v = "nvim";
            vi = "nvim";
            vim = "nvim";
            g = "git";
            gcl = "git clone";
            gco = "git checkout";
            gcm = "git commit -m";
            ga = "git add";
            gs = "git status";
            gd = "git diff";
            gb = "git branch";
            gl = "git log";
            gp = "git push";
            gpl = "git pull";
            gpr = "git pull --rebase";
            gpf = "git push --force";
            update = "cd /home/danb127/.dotfiles && sudo nixos-rebuild switch --flake .#nixos-danb127";
            battery = "acpi -b";
        };
        
        # History
        history = {
            size = 50000;
            path = "/home/danb127/.zsh_history";
        };

        # Oh-my-zsh plugins
        oh-my-zsh = {
            enable = true;
            plugins = [
                "git"
                "fzf"
                "vi-mode"

            ];
        };

        plugins = [
            {
                name = "powerlevel10k";
                src = pkgs.zsh-powerlevel10k;
                file = "share/zsh-powerlevel10k/powerlevel10k.zsh-theme";
            }

        ];

    };
}
