{ inputs, ... }:

{
  imports = [ inputs.nixvim.homeModules.default ];

  programs.nixvim = {
    enable = true;
    colorschemes.catppuccin.enable = true;
    globals.mapleader = " ";

    opts = {
      number = true;
      relativenumber = true;
      undofile = true;
      splitbelow = true;
      splitright = true;
      expandtab = true;
      tabstop = 2;
      shiftwidth = 0;
    };

    plugins.lz-n.enable = true;
    plugins.mini-pick.enable = true;
    plugins.mini-files.enable = true;
    plugins.mini-pairs.enable = true;
    plugins.treesitter = {
      enable = true;
      highlight.enable = true;
      indent.enable = true;
      # folding.enable = true;
    };
    plugins.cmp.enable = true;
    plugins.neogit.enable = true;

    keymaps = [
      {
        action = "<cmd>Pick files<CR>";
        key = "<leader>ff";
      }
      {
        action = "<cmd>Pick buffers<CR>";
        key = "<leader>fb";
      }
      {
        action = "<cmd>Pick grep_live<CR>";
        key = "<leader>fg";
      }
      {
        action = "<cmd>Pick help<CR>";
        key = "<leader>fh";
      }
      {
        action = "<cmd>lua MiniFiles.open()<CR>";
        key = "<leader>fm";
      }
      {
        action = "<cmd>Neogit<CR>";
        key = "<leader>gg";
      }
    ];
  };
}
