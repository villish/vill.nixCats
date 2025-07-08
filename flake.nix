{
  description = "A Lua-natic's neovim flake, with extra cats! nixCats!";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    nixCats.url = "github:BirdeeHub/nixCats-nvim";

    # see :help nixCats.flake.inputs
    # https://nixos.org/manual/nix/stable/command-ref/new-cli/nix3-flake.html#examples

  };

  # see :help nixCats.flake.outputs
  outputs = { self, nixpkgs, nixCats, ... }@inputs:
    let
      inherit (nixCats) utils;
      luaPath = ./.;
      forEachSystem = utils.eachSystem nixpkgs.lib.platforms.all;
      extra_pkg_config = { allowUnfree = true; };

      dependencyOverlays = # (import ./overlays inputs) ++
        [
          # This overlay grabs all the inputs named in the format
          # `plugins-<pluginName>`
          # Once we add this overlay to our nixpkgs, we are able to
          # use `pkgs.neovimPlugins`, which is a set of our plugins.
          (utils.standardPluginOverlay inputs)
          # add any other flake overlays here.

          # when other people mess up their overlays by wrapping them with system,
          # you may instead call this function on their overlay.
          # it will check if it has the system in the set, and if so return the desired overlay
          # (utils.fixSystemizedOverlay inputs.codeium.overlays
          #   (system: inputs.codeium.overlays.${system}.default)
          # )
        ];

      # see :help nixCats.flake.outputs.categories
      # and
      # :help nixCats.flake.outputs.categoryDefinitions.scheme
      categoryDefinitions =
        { pkgs, settings, categories, extra, name, mkPlugin, ... }@packageDef: {
          # to define and use a new category, simply add a new list to a set here,
          # and later, you will include categoryname = true; in the set you
          # provide when you build the package using this builder function.
          # see :help nixCats.flake.outputs.packageDefinitions for info on that section.

          # lspsAndRuntimeDeps:
          # this section is for dependencies that should be available
          # at RUN TIME for plugins. Will be available to PATH within Neovim terminal
          # this includes LSPs
          lspsAndRuntimeDeps = with pkgs; {
            general = [
              universal-ctags
              curl
              # NOTE:
              # lazygit
              # Apparently lazygit when launched via snacks cant create its own config file
              # but we can add one from nix!
              (pkgs.writeShellScriptBin "lazygit" ''
                exec ${pkgs.lazygit}/bin/lazygit --use-config-file ${
                  pkgs.writeText "lazygit_config.yml" ""
                } "$@"
              '')
              ripgrep
              fd
              stdenv.cc.cc
              lua-language-server
              nixd
              nixfmt-classic
              stylua
              clang-tools

              ## markdown
              markdownlint-cli2
              marksman

              ## rust
              rust-analyzer
              cargo
              clippy
              harper
            ];
          };

          startupPlugins = with pkgs.vimPlugins; {
            general = [
              outline-nvim
              yanky-nvim
              windsurf-nvim
              blink-compat
              crates-nvim
              rustaceanvim
              catppuccin-nvim
              lazy-nvim
              LazyVim
              bufferline-nvim
              lazydev-nvim
              conform-nvim
              flash-nvim
              render-markdown-nvim
              friendly-snippets
              nvim-surround
              vim-tmux-navigator
              gitsigns-nvim
              grug-far-nvim
              hop-nvim
              noice-nvim
              lualine-nvim
              nui-nvim
              nvim-lint
              nvim-lspconfig
              nvim-treesitter-textobjects
              nvim-ts-autotag
              ts-comments-nvim
              blink-cmp
              colorful-menu-nvim
              nvim-web-devicons
              persistence-nvim
              plenary-nvim
              telescope-fzf-native-nvim
              telescope-nvim
              todo-comments-nvim
              tokyonight-nvim
              trouble-nvim
              vim-illuminate
              vim-startuptime
              which-key-nvim
              snacks-nvim
              nvim-treesitter-textobjects
              nvim-treesitter.withAllGrammars
              # smart-splits-nvim
              # This is for if you only want some of the grammars
              # (nvim-treesitter.withPlugins (
              #   plugins: with plugins; [
              #     nix
              #     lua
              #   ]
              # ))

              # sometimes you have to fix some names
              {
                plugin = mini-ai;
                name = "mini.ai";
              }
              {
                plugin = mini-icons;
                name = "mini.icons";
              }
              {
                plugin = mini-pairs;
                name = "mini.pairs";
              }
              # you could do this within the lazy spec instead if you wanted
              # and get the new names from `:NixCats pawsible` debug command
            ];
          };

          optionalPlugins = { };

          # shared libraries to be added to LD_LIBRARY_PATH
          # variable available to nvim runtime
          sharedLibraries = {
            general = with pkgs;
              [
                # libgit2
              ];
          };

          # environmentVariables:
          # this section is for environmentVariables that should be available
          # at RUN TIME for plugins. Will be available to path within neovim terminal
          environmentVariables = { };

          # If you know what these are, you can provide custom ones by category here.
          # If you dont, check this link out:
          # https://github.com/NixOS/nixpkgs/blob/master/pkgs/build-support/setup-hooks/make-wrapper.sh
          extraWrapperArgs = { };

          # lists of the functions you would have passed to
          # python.withPackages or lua.withPackages

          # get the path to this python environment
          # in your lua config via
          # vim.g.python3_host_prog
          # or run from nvim terminal via :!<packagename>-python3
          python3.libraries = { test = [ (_: [ ]) ]; };
          # populates $LUA_PATH and $LUA_CPATH
          extraLuaPackages = { test = [ (_: [ ]) ]; };
        };

      # And then build a package with specific categories from above here:
      # All categories you wish to include must be marked true,
      # but false may be omitted.
      # This entire set is also passed to nixCats for querying within the lua.

      # see :help nixCats.flake.outputs.packageDefinitions
      packageDefinitions = {
        # These are the names of your packages
        # you can include as many as you wish.
        nvim = { pkgs, name, mkPlugin, ... }: {
          # they contain a settings set defined above
          # see :help nixCats.flake.outputs.settings
          settings = {
            suffix-path = true;
            suffix-LD = true;
            wrapRc = true;
            # IMPORTANT:
            # your alias may not conflict with your other packages.
            # aliases = [ "vim" ];
            # neovim-unwrapped = inputs.neovim-nightly-overlay.packages.${pkgs.system}.neovim;
            hosts.python3.enable = true;
            hosts.node.enable = true;
          };
          # and a set of categories that you want
          # (and other information to pass to lua)
          categories = {
            general = true;
            test = false;
          };
          extra = { };
        };
        # Portable package for releases - no Nix store dependencies
        nvim-portable = { pkgs, name, mkPlugin, ... }: {
          settings = {
            suffix-path = true;
            suffix-LD = true;
            wrapRc = false;
            # Bundle the config directory into the package
            configDirName = "nvim-config";
            hosts.python3.enable = true;
            hosts.node.enable = true;
          };
          categories = {
            general = true;
            test = false;
          };
          extra = { };
        };
        # an extra test package with normal lua reload for fast edits
        # nix doesnt provide the config in this package, allowing you free rein to edit it.
        # then you can swap back to the normal pure package when done.
        testnvim = { pkgs, mkPlugin, ... }: {
          settings = {
            suffix-path = true;
            suffix-LD = true;
            wrapRc = false;
            unwrappedCfgPath = utils.mkLuaInline
              "os.getenv('HOME') .. '/some/path/to/your/config'";
          };
          categories = {
            general = true;
            test = false;
          };
          extra = { };
        };
      };
      # In this section, the main thing you will need to do is change the default package name
      # to the name of the packageDefinitions entry you wish to use as the default.
      defaultPackageName = "nvim";

      # see :help nixCats.flake.outputs.exports
    in forEachSystem (system:
      let
        # the builder function that makes it all work
        nixCatsBuilder = utils.baseBuilder luaPath {
          inherit nixpkgs system dependencyOverlays extra_pkg_config;
        } categoryDefinitions packageDefinitions;
        defaultPackage = nixCatsBuilder defaultPackageName;
        # this is just for using utils such as pkgs.mkShell
        # The one used to build neovim is resolved inside the builder
        # and is passed to our categoryDefinitions and packageDefinitions
        pkgs = import nixpkgs { inherit system; };
      in {
        # these outputs will be wrapped with ${system} by utils.eachSystem

        # this will make a package out of each of the packageDefinitions defined above
        # and set the default package to the one passed in here.
        packages = utils.mkAllWithDefault defaultPackage;

        # choose your package for devShell
        # and add whatever else you want in it.
        devShells = {
          default = pkgs.mkShell {
            name = defaultPackageName;
            packages = [ defaultPackage ];
            inputsFrom = [ ];
            shellHook = "";
          };
        };

      }) // (let
        # we also export a nixos module to allow reconfiguration from configuration.nix
        nixosModule = utils.mkNixosModules {
          moduleNamespace = [ defaultPackageName ];
          inherit defaultPackageName dependencyOverlays luaPath
            categoryDefinitions packageDefinitions extra_pkg_config nixpkgs;
        };
        # and the same for home manager
        homeModule = utils.mkHomeModules {
          moduleNamespace = [ defaultPackageName ];
          inherit defaultPackageName dependencyOverlays luaPath
            categoryDefinitions packageDefinitions extra_pkg_config nixpkgs;
        };
      in {

        # these outputs will be NOT wrapped with ${system}

        # this will make an overlay out of each of the packageDefinitions defined above
        # and set the default overlay to the one named here.
        overlays = utils.makeOverlays luaPath {
          inherit nixpkgs dependencyOverlays extra_pkg_config;
        } categoryDefinitions packageDefinitions defaultPackageName;

        nixosModules.default = nixosModule;
        homeModules.default = homeModule;

        inherit utils nixosModule homeModule;
        inherit (utils) templates;
      });
}
