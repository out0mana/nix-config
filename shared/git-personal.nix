{ pkgs, ... }:
{
  programs.git = {
    enable = true;
    config = {
      user = {
        name = "out0mana";
        email = "out0mana@fakemail";
      };
    };
  };
}
