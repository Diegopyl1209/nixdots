{
  inputs,
  pkgs,
  ...
}: {
  home.packages = with pkgs; [
    #inputs.Lumi.packages.${system}.default
    commitizen
  ];
  programs.lazygit = {
    enable = true;
    settings = {
      customCommands = [
        {
          key = "c";
          command = "git cz c";
          description = "Commit with commitzen";
          context = "files";
          loadingText = "Opening commitzen...";
          subprocess = true;
        }
      ];
    };
  };

  programs.nixvim = {
    enable = true;
    colorschemes.gruvbox.enable = true;
    clipboard.providers.wl-copy.enable = true;
    opts = {
      number = true;
      relativenumber = true;

      shiftwidth = 2;
    };
    plugins = {
      lualine.enable = true;
      telescope.enable = true;
      web-devicons.enable = true;
      nix.enable = true;
      yazi.enable = true;
      vimtex.enable = true;
      cmp = {
        enable = true;
        autoEnableSources = true;
        settings = {
          completion = {
            autocomplete = [
              "require('cmp.types').cmp.TriggerEvent.TextChanged"
            ];
          };
          mapping = {
            "<C-Space>" = "cmp.mapping.complete()";
            "<C-d>" = "cmp.mapping.scroll_docs(-4)";
            "<C-e>" = "cmp.mapping.close()";
            "<C-f>" = "cmp.mapping.scroll_docs(4)";
            "<CR>" = "cmp.mapping.confirm({ select = true })";
            "<S-Tab>" = "cmp.mapping(cmp.mapping.select_prev_item(), {'i', 's'})";
            "<Tab>" = "cmp.mapping(cmp.mapping.select_next_item(), {'i', 's'})";
          };
          sources = [
            {name = "path";}
            {name = "nvim_lsp";}
            {name = "luasnip";}
            {
              name = "buffer";
              # Words from other open buffers can also be suggested.
              option.get_bufnrs.__raw = "vim.api.nvim_list_bufs";
            }
          ];
        };
      };
      cmp-nvim-lsp = {
        enable = true;
        autoLoad = true;
      };
      lsp = {
        enable = true;
        servers = {
          nixd.enable = true;
          bashls.enable = true;
          java_language_server.enable = true;
          kotlin_language_server.enable = true;
        };
      };
    };
  };
}
