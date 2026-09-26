# New install
- Create a nixos usb drive
  - Get iso: `wget https://channels.nixos.org/nixos-26.05/latest-nixos-minimal-x86_64-linux.iso`
  - Find usb drive: `lsblk`
  - Copy iso to drive: `sudo dd if=nixos.iso of=/dev/sdX bs=4M status=progress conv=fdatasync`
- Boot from drive
- Clone repo `git clone https://github.com/out0mana/nix-config.git`
- Generate `hardware-configuration.nix` using `nixos-generate-config --root ~`
- Copy hardware config to host folder `cp hardware-configuration.nix ~/nix-config/<host>/`
- Install with `nixos-install --flake ~/nix-config/flake.nix#<host>`