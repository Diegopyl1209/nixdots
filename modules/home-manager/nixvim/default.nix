{
  config,
  inputs,
  pkgs,
  ...
}: {
  programs.nixvim = {
    enable = true;
    colorschemes.gruvbox.enable = true;
    opts = {
      number = true;
      relativenumber = true;

      shiftwidth = 2;
    };
    plugins = {
      lualine.enable = true;
      telescope.enable = true;
      nix.enable = true;
      nix-develop.enable = true;
      oil.enable = true;
      treesitter.enable = true;
      luasnip.enable = true;
    };
    keymaps = [
      {
        action = "<cmd>Telescope live_grep<CR>";
        key = "<leader>g";
      }
    ];
  };
}
