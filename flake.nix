{
  description = "myShit";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    fresh.url = "github:sinelaw/fresh";   # the fresh editor flake
  };

  outputs = { self, nixpkgs, fresh }:
    let
      system = "x86_64-linux";
      # Import nixpkgs with unfree packages allowed (for VSCode)
      pkgs = import nixpkgs {
        inherit system;
        config.allowUnfree = true;
      };

      # All the packages you want in your profile
      myPackages = [
        # From the fresh flake – note: NOT from pkgs
        fresh.packages.${system}.default

        # Everything below comes from nixpkgs (pkgs.*)
		pkgs.devenv
        pkgs.rsyncy
        pkgs.vscode
        pkgs.rofi
        pkgs.atuin
        pkgs.blesh
        pkgs.zoxide
        pkgs.yazi
        pkgs.git
        pkgs.micro
        pkgs.xed
        pkgs.isd
        pkgs.dog
        pkgs.systemctl-tui
        pkgs.lazyjournal
        pkgs.lazygit
        pkgs.lazyssh
        pkgs.lla
        pkgs.bat
        pkgs.nix-tree
		plgs.nix-output-monitor
        pkgs.btop
        pkgs.bandwhich
        pkgs.doggo
        pkgs.rustscan
        pkgs.gping
        pkgs.trippy
        pkgs.microfetch
        pkgs.fastfetch
        pkgs.wl-clipboard
        pkgs.eza
        pkgs.fzf
        pkgs.jq
        pkgs.ripgrep
        pkgs.television
        pkgs.tldr
        pkgs.nh
        pkgs.gh
        pkgs.ncdu
        pkgs.nix-du
        pkgs.comma
        pkgs.nix-init
        pkgs.nix-melt
        pkgs.nix-index
        pkgs.nix-search-cli
        pkgs.yt-dlp
        pkgs.duf
        pkgs.dust
        pkgs.nmap
        pkgs.ninja_1_11
        pkgs.cmake
        pkgs.pkg-config
        pkgs.gnumake
        pkgs.gdb
        pkgs.gcc15
        pkgs.clang-tools
        pkgs.codespell
#        pkgs.conan
        pkgs.cppcheck
        pkgs.doxygen
        pkgs.gtest
        pkgs.lcov
        pkgs.vcpkg-tool
        pkgs.gtk3
        pkgs.boost
        pkgs.neovim
        pkgs.tmux
      ];
    in
    {
      # The default package for this flake is an environment containing all tools
      packages.${system}.default = pkgs.buildEnv {
        name = "my-tools";
        paths = myPackages;
        pathsToLink = [ "/bin" "/share" "/etc" ];
      };
    };
}
