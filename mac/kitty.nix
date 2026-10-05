{ inputs, ... }:
{
  imports = [
    inputs.catppuccin.homeModules.catppuccin
  ];
  catppuccin.enable = true;
  programs.kitty = {
    enable = true;
    shellIntegration = {
      enableBashIntegration = true;
      enableZshIntegration = true;
      enableFishIntegration = true;
    };
  };
}
