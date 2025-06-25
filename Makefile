.PHONY: help build test check clean format format-check install-hooks update dev

help:
	@echo "nixCats Development Commands:"
	@echo ""
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "  \033[36m%-20s\033[0m %s\n", $$1, $$2}'

build:
	nix build .#nvim

test:
	nix flake check

check:
	nix flake check
	nix flake show

clean:
	rm -rf result*
	nix-collect-garbage

format:
	nix run nixpkgs#stylua -- .
	nix run nixpkgs#nixfmt-classic -- flake.nix

format-check:
	nix run nixpkgs#stylua -- --check .
	nix run nixpkgs#nixfmt-classic -- --check flake.nix

install-hooks:
	nix run nixpkgs#pre-commit -- install

update:
	nix flake update

dev:
	nix develop

run:
	./result/bin/nvim

info:
	nix run .#nvim -- --version
	@echo ""
	@echo "Available packages:"
	@nix flake show | grep packages

audit:
	nix run nixpkgs#vulnix -- --system x86_64-linux .#nvim

benchmark:
	hyperfine --warmup 3 "./result/bin/nvim --headless +q" || echo "Install hyperfine for benchmarks: nix profile install nixpkgs#hyperfine"
