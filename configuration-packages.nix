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

	## DOCKER ##
	virtualisation.docker.enable = true;
	users.extraGroups.docker.members = [ "gchalakov" ];
	hardware.nvidia-container-toolkit.enable = true; # use --device=nvidia.com/gpu=all instead of gpu=all

	## SSH ##
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
	boot.initrd.kernelModules = [ "nvidia" ];
	boot.extraModulePackages = [ config.boot.kernelPackages.nvidia_x11 ];

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

	## CUDA ##
	nix.settings = {
		substituters = [ "https://cache.nixos-cuda.org" ];
		trusted-public-keys = [ "cache.nixos-cuda.org:74DUi4Ye579gUqzH4ziL9IyiJBlDpMRn9MBN8oNan9M=" ];
	};
	
	## OLLAMA ##
	services.ollama = {
		enable = true;
		acceleration = "cuda";
	};
}
