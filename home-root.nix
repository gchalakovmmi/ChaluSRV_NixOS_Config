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

	## GitHub SSH key
	programs.ssh = {
		enable = true;
		enableDefaultConfig = false;
		matchBlocks = {
			"*" = {
				extraOptions = {
					AddKeysToAgent = "yes";
				};
				identityFile = "/root/.ssh/github_gc_rsa";
			};
		};
	};
	services.ssh-agent.enable = true;
}
