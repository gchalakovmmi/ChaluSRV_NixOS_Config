{ config, lib, pkgs, ... }:

{
	imports =
		[
			./hardware-configuration.nix
			./configuration-packages.nix
		];

	# Use the systemd-boot EFI boot loader.
	boot.loader.systemd-boot.enable = true;
	boot.loader.efi.canTouchEfiVariables = true;

	networking.hostName = "ChaluSRVLenovo";
	# Pick only one of the below networking options.
	# networking.wireless.enable = true;		# Enables wireless support via wpa_supplicant.
	networking.networkmanager.enable = true;	# Easiest to use and most distros use this by default.

	time.timeZone = "Europe/Sofia";

	users.users.gchalakov = {
		isNormalUser = true;
		extraGroups = [ "wheel" ]; # Enable ‘sudo’ for the user.
		packages = with pkgs; [
			tree
		];
	};

	# ## MOUNT BKP HDD ##
	# fileSystems."/home/gchalakov/backup" = {
	# 	device = "/dev/disk/by-uuid/82c59328-6016-44ac-a6ab-291f7fe9ea9f";
	# 	fsType = "ext4";
	# 	options = [ # If you don't have this options attribute, it'll default to "defaults"
	# 	# boot options for fstab. Search up fstab mount options you can use
	# 		# "users" # Allows any user to mount and unmount
	# 		"nofail" # Prevent system from failing if this drive doesn't mount
	# 	];
	# };

	# Open ports in the firewall.
	networking.firewall.allowedTCPPorts = [ 22 443 80 3478 8081 ];
	networking.firewall.allowedUDPPorts = [ 3478 ];
	# Or disable the firewall altogether.
	# networking.firewall.enable = false;

	nix.settings.experimental-features = [ "nix-command" "flakes" ];

	# DO NOT EDIT #
	system.stateVersion = "25.05"; # Did you read the comment?
}

