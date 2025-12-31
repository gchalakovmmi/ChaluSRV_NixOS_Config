{ config, lib, pkgs, ... }:

{
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
}
