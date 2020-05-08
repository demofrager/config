{ config, pkgs, ... }:

{
  imports = [ ./hardware-configuration.nix ];

  boot.loader.grub.device = "/dev/sda";

  programs.vim.defaultEditor = true;

  virtualisation = {
    virtualbox.guest = {
      enable = true;
      x11 = true;
    };
    docker.enable = true;
  };

  # networking = {
  #	interfaces = {
  #		enp0s3.useDHCP = true;	
  #		enp0s8.ipv4.addresses = [ { address = "192.168.200.1"; prefixLength = 28; } ] ;
  #  	};
  #	extraHosts = "192.168.200.1 api.kube";
  #  }; 

  # GUI
  services.xserver = {
    enable = true;
    desktopManager.plasma5.enable = true;
    displayManager.sddm.enable = true;
  };

  # Let demo build as a trusted user.
  # nix.trustedUsers = [ "demo" ];

  # Set your time zone.
  time.timeZone = "Europe/Zurich";

  # List packages installed in system profile. Stuff used in the terminal. To search, run:
  # \$ nix search wget
  environment.systemPackages = with pkgs; [
    docker-compose
    nixfmt
    git
    firefox
    ipcalc
    atom
    #go
    #python
  ];

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  users.users.demofrager = {
    initialPassword = "demo";
    isNormalUser = true;
    extraGroups = [ "wheel" "docker" ];
  };
}
