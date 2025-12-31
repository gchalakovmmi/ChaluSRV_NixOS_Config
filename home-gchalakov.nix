{ config, pkgs, ... }:

{
	home.username = "gchalakov";
	home.homeDirectory = "/home/gchalakov";
	home.stateVersion = "25.11";
	programs.bash = {
		enable = true;
		shellAliases = {
			v = "nvim";
			vi = "nvim";
			vim = "nvim";
		};
	};
}
