{ pkgs, ... }:
{
  programs.git = {
    enable = true;
    config = {
      push = {
        autoSetupRemote = true;
      };
      pull = {
        rebase = false;
      };
      user = {
        name = "out0mana";
        email = "out0mana@fakemail";
      };
    };
  };
}
