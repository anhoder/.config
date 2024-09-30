hostname ?= anhoder

darwin-deploy:
	nix build .#darwinConfigurations.$(hostname).system \
	   --extra-experimental-features 'nix-command flakes'

	./result/sw/bin/darwin-rebuild switch --flake .#$(hostname)

home-build:
	nix run 'home-manager' -- --flake . build

home-switch:
	nix run 'home-manager' -- --flake . switch
