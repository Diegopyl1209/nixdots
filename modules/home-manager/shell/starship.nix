{lib, ...}: let
  lang = icon: color: {
    symbol = icon;
    format = "[$symbol ](${color})";
  };
in {
  programs.starship = {
    enable = true;
    settings = {
      add_newline = true;
      format = lib.strings.concatStrings [
        "$nix_shell"
        "$os"
        "$directory"
        "$container"
        "$git_branch $git_status"
        "$python"
        "$nodejs"
        "$lua"
        "$rust"
        "$java"
        "$c"
        "$golang"
        "$cmd_duration"
        "$status"
        "\n$username$sudo$character"
      ];
      status = {
        symbol = " ✗";
        not_found_symbol = " 󰍉 Not Found";
        not_executable_symbol = "  Can't Execute E";
        sigint_symbol = " 󰂭 ";
        signal_symbol = " 󱑽 ";
        success_symbol = "";
        format = "[$symbol](fg:red)";
        map_symbol = true;
        disabled = false;
      };
      cmd_duration = {
        min_time = 1000;
        format = "[ ◕ $duration](244)";
      };
      character = {
        format = "$symbol ";
        success_symbol = "[●](bright-green)";
        error_symbol = "[●](red)";
        vicmd_symbol = "[◆](blue)";
      };
      nix_shell = {
        disabled = false;
        format = "[](fg:white)[](bg:white fg:black)[](fg:white) ";
      };
      container = {
        symbol = " 󰏖";
        format = "[$symbol ](yellow dimmed)";
      };
      directory = {
        home_symbol = "⌂ ";
        truncation_length = 2;
        #truncation_symbol = "□ ";
        read_only = " △";
        use_os_path_sep = true;
        style = "bright-blue";
      };
      directory.substitutions = {
        "Documentos" = "󰈙 ";
        "Descargas" = " ";
        "Música" = " ";
        "Imágenes" = " ";
        "Videos" = " ";
        "Proyectos" = "󱌢 ";
        "GitHub" = "";
        ".config" = " ";
      };
      git_branch = {
        symbol = "";
        style = "";
        format = "[ $symbol $branch](fg:purple)(:$remote_branch)";
      };
      os = {
        disabled = false;
        # format = "[](fg:blue)[$symbol](bg:blue fg:black)[](fg:blue)";
        format = "$symbol";
      };
      sudo = {
        format = "[$symbol]($style)";
        style = "bright-purple";
        symbol = ":";
        disabled = false;
      };
      os.symbols = {
        Arch = "[ ](fg:bright-blue)";
        Debian = "[ ](fg:red)";
        EndeavourOS = "[ ](fg:purple)";
        Fedora = "[ ](fg:blue)";
        NixOS = "[ ](fg:blue)";
        openSUSE = "[ ](fg:green)";
        SUSE = "[ ](fg:green)";
        Ubuntu = "[ ](fg:bright-purple)";
      };
      python = lang "" "yellow";
      nodejs = lang " " "yellow";
      lua = lang "󰢱" "blue";
      rust = lang "" "red";
      java = lang "" "red";
      c = lang "" "blue";
      golang = lang "" "blue";
    };
  };
}
