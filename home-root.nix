{ config, pkgs, ... }:

{
	home.username = "root";
	home.homeDirectory = "/root";
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
