# ~/.dotfiles/home-manager/rofi.nix
{ config, lib, pkgs, ... }:

{
  # Enable Rofi
  programs.rofi = {
    enable = true;

    theme = "~/.config/rofi/theme.rasi";

    terminal = "kitty";

    font = "Droid Sans Mono 14";
  };


}
