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

	# ## GitHub SSH key
	# programs.ssh = {
	# 	enable = true;
	# 	enableDefaultConfig = false;
	# 	matchBlocks = {
	# 		"*" = {
	# 			extraOptions = {
	# 				AddKeysToAgent = "yes";
	# 			};
	# 			identityFile = "/home/gchalakov/.ssh/github_gc_rsa";
	# 		};
	# 	};
	# };
	# services.ssh-agent.enable = true;
}
