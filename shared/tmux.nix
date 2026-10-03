{ pkgs, ... }:

{
  programs.tmux = {
    enable = true;
    terminal = "tmux-direct";
    plugins = [
      {
        plugin = pkgs.tmuxPlugins.catppuccin;
        extraConfig = ''
          set -g @catppuccin_flavor "mocha"
        '';
      }
    ];
    extraConfig = ''
      set -g mouse on
      set-option -g default-terminal "screen-256color"
      # set-option -sa terminal-overrides ",xterm-256color:Tc"
      # set-option -ga terminal-features ",xterm-256color:RGB"
    '';
  };
}
