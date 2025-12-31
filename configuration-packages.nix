{ config, lib, pkgs, ... }:

{
	nixpkgs.config.allowUnfree = true;

	environment.systemPackages = with pkgs; [
		neovim
		wget
		git
		tmux
		btop
		xorg.xauth
		firefox
		speedtest-cli
		docker-compose
		neofetch
		nvtopPackages.nvidia
	];

	virtualisation.docker.enable = true;
	users.extraGroups.docker.members = [ "gchalakov" ];

	programs.ssh = {
		startAgent = true;
		extraConfig = ''
			AddKeysToAgent yes
			IdentityFile ~/.ssh/github_gc_rsa
		'';
	};

	services.openssh = {
		enable = true;
		settings = {
			PasswordAuthentication = false;
			KbdInteractiveAuthentication = false;
			PermitRootLogin = "no";
			AllowUsers = [ "gchalakov" ];

			# Don't break connection oninactivity
			ClientAliveInterval = 60;
			ClientAliveCountMax = 10;
			TCPKeepAlive = "yes";

			# To access GUI apps remotely
			X11Forwarding = true;
			X11UseLocalhost = false;
		};
	};
	services.fail2ban.enable = true;


	## NVIDIA ##
	hardware.graphics.enable = true;
	# Load nvidia driver for Xorg and Wayland
	services.xserver.videoDrivers = ["nvidia"];
	hardware.nvidia = {
		modesetting.enable = true;
		powerManagement.enable = false;
		powerManagement.finegrained = false;
		open = true;
		package = config.boot.kernelPackages.nvidiaPackages.stable;
	};
}
