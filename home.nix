{ config, pkgs, ... }:

{
	home.username = "gchalakov";
	home.homeDirectory = "/home/gchalakov";
	programs.git.enable = true;
	home.stateVersion = "25.05";
	programs.bash = {
		enable = true;
		shellAliases = {
			v = "nvim";
			vi = "nvim";
			vim = "nvim";
		};
	};
}
