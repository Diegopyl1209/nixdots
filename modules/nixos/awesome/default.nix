{ pkgs, inputs, ...}:
{
	services.xserver = {
		windowManager.awesome.enable = true;
	};
	
	environment.systemPackages = with pkgs; [
		wezterm
	];
}
