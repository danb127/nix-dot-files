# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      ./hyprland-sessions.nix

    ];

  # Bootloader.
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.grub = {
	enable = true;
	efiSupport = true;
	efiInstallAsRemovable = false;
	device = "nodev";
	useOSProber = true;
};

  networking.hostName = "nixos"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;


  security = {
  pam.services.sddm.enableGnomeKeyring = true;
  polkit.enable = true;
  sudo.extraConfig = ''
    Defaults lecture = never
  '';
};

services.gnome.gnome-keyring.enable = true;




  # Set your time zone.
  time.timeZone = "America/Detroit";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_US.UTF-8";
    LC_IDENTIFICATION = "en_US.UTF-8";
    LC_MEASUREMENT = "en_US.UTF-8";
    LC_MONETARY = "en_US.UTF-8";
    LC_NAME = "en_US.UTF-8";
    LC_NUMERIC = "en_US.UTF-8";
    LC_PAPER = "en_US.UTF-8";
    LC_TELEPHONE = "en_US.UTF-8";
    LC_TIME = "en_US.UTF-8";
  };



  # Hyprland Setup
    programs.hyprland = {
    enable = true;
    xwayland.enable = true;
    portalPackage = pkgs.xdg-desktop-portal-hyprland;
    withUWSM = true;
    };


    qt = {
  enable = true;
  platformTheme = "qt5ct";
  style = "adwaita-dark";
};

  # Optional: Enable XWayland support
  programs.xwayland.enable = true;
  
  programs.zsh.enable = true;

  # XDG portal services
  xdg.portal.enable = true;
  xdg.portal.extraPortals = [ pkgs.xdg-desktop-portal-gtk ];

  # Enable the X11 windowing system.
  # You can disable this if you're only using the Wayland session.
  services.xserver = {
    enable = true;
    displayManager.sessionPackages = [ pkgs.hyprland ];
    displayManager.gdm.enable = false;
    displayManager.defaultSession = "hyprland";
  };

  services.displayManager= {
    sessionPackages = [ pkgs.hyprland ];
    sddm.enable = true;
    defaultSession = "hyprland";
    };
  
  services.flatpak.enable = true;

  services.tor = {
    enable = true;  
    client.enable = true;
  };

# Enable Power Profiles Daemon
services.power-profiles-daemon.enable = true;

 # Fonts
 fonts.packages = with pkgs; [
  jetbrains-mono
  noto-fonts
  noto-fonts-cjk-sans
  noto-fonts-emoji
  liberation_ttf
  fira-code
  fira-code-symbols
  mplus-outline-fonts.githubRelease
  dina-font
  proggyfonts
  
] ++ builtins.filter lib.attrsets.isDerivation (builtins.attrValues pkgs.nerd-fonts);




  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound with pipewire.
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.danb127 = {
    isNormalUser = true;
    description = "danb127-nixos";
    extraGroups = [ "networkmanager" "wheel" "audio" "video" "input" "users" "systemd-journal" "power-profiles-daemon" "render" "pulse" "pipewire" "tor" "torbrowser-launcher"];
    packages = with pkgs; [
      kdePackages.kate
    #  thunderbird
    ];
    shell = pkgs.zsh;
  };

  # Install firefox.
  programs.firefox.enable = true;


  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;
  programs.nix-ld.enable = true;
  programs.nix-ld.libraries = with pkgs; [ pkgs.glibc ];


  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
   
   hyprland # window manager compositor
  
   wayland # compositor environment

   neovim # text editor

   betterlockscreen # lockscreen

   wget # download manager

   wlroots # Wayland compositor library 

   wayland-utils # Wayland utilities

   waybar

   meson # build system

   (pkgs.waybar.overrideAttrs (oldAttrs: {
   	mesonFlags = oldAttrs.mesonFlags ++ ["-Dexperimental=true"];
      })
   )
   
   pkgs.dunst

   libnotify

   # Application launchers
   rofi-wayland
   wofi

   kitty

   tree

    # Battery and power management
   acpi

   # Git packages
   pkgs.git
   
   # Operating System prober
   pkgs.os-prober
   
   # Make your own bar with Elkowar's widgets
   # Own markup language
   pkgs.eww

   # tor browser
   tor-browser-bundle-bin

   # Wallpaper options
   hyprpaper
   swww
   swaybg
   mpvpaper
   wpaperd
   
   # HyprPanel and dependencies
   pipewire
   libgtop
   bluez
   grimblast
   gpu-screen-recorder
   hyprpicker
   btop
   matugen
   wl-clipboard
   dart-sass
   brightnessctl
   gnome-bluetooth
   gtk-layer-shell
   gobject-introspection
   networkmanager
   power-profiles-daemon
   hyprsunset
   hypridle
   swww


   # Optional dependencies
   python3
   python3Packages.gpustat
   pywal
   power-profiles-daemon

   # Fonts
   
   jetbrains-mono

   # LaTeX packages
   pkgs.texlive.combined.scheme-full

   # Okular
   okular

   # Rust
   rustup

    # Dependencies for AGS v2
    go
    nodejs
    nmap
    ags
    bun    # Add ags and bun

    # Obsidian app 
    obsidian

    # Discord app
    pkgs.discord

    # Toolchain dependencies
    gcc # GNU Compiler Collection
    gnumake # GNU Make
    autoconf # Generate configure scripts
    bison # parser generator
    flex # Lexical analyzer
    texinfo
    help2man
    gawk
    libtool # Generic library support
    ncurses # terminal handling library
    unzip # unzip utility
    gettext # get text utility
    automake # tool to generate Makefile.in files
    file # file type identification utility

  ];



  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.05"; # Did you read the comment?
  
  nix = {
    package = pkgs.nixVersions.stable;


    settings.experimental-features = [ "nix-command" "flakes" ];

    };

  environment.variables = {

        GI_TYPELIB_PATH = "${pkgs.libgtop}/lib/girepository-1.0";
        };

}
