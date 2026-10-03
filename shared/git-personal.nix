{ pkgs, ... }:
{
  programs.git = {
    enable = true;
    config = {
      push = {
        autoSetupRemote = true;
      };
      user = {
        name = "out0mana";
        email = "out0mana@fakemail";
      };
    };
  };
}
