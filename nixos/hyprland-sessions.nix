# ~/.dotfiles/nixos/hyprland-session.nix
{ config, pkgs, ... }:
{
  environment = {
    etc."sddm/wayland-sessions/hyprland.desktop".text = ''
      [Desktop Entry]
      Name=Hyprland
      Comment=Hyprland Wayland compositor
      Exec=${pkgs.hyprland}/bin/Hyprland
      Type=Application
    '';
  };
}
