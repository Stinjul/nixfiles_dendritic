{
  inputs,
  self,
  ...
}:
{
  flake.modules.nixos.user-stinjul-desktop = {
    # imports = with inputs.self.modules.nixos; [
    #   gtk
    # ];
  };
  flake.modules.homeManager.user-stinjul-desktop =
    {
      pkgs,
      lib,
      config,
      ...
    }:
    {
      stylix = {
        base16Scheme = {
          #   system = "base16";
          name = "Custom";
          author = "Stinjul";
          variant = "dark";
          palette = {
            base00 = "#1B1918";
            base01 = "#2C2624";
            base02 = "#3B3532";
            base03 = "#655D57";
            base04 = "#7E7770";
            base05 = "#DCD7D4";
            base06 = "#E8E4E2";
            base07 = "#F1EFEE";
            base08 = "#dd0e23";
            base09 = "#d75f00";
            base0A = "#a87214";
            base0B = "#47902c";
            base0C = "#007a6e";
            base0D = "#1b62d9";
            base0E = "#7b39e4";
            base0F = "#D9534F";
            base10 = "#141210";
            base11 = "#0B0A09";
            base12 = "#f22c40";
            base13 = "#d5911a";
            base14 = "#5ab738";
            base15 = "#00ad9c";
            base16 = "#407ee7";
            base17 = "#9966ea";
          };
        };
        fonts = {
          serif = {
            package = pkgs.iosevka;
            name = "Iosevka Slab";
          };
          sansSerif = {
            package = pkgs.iosevka;
            name = "Iosevka";
          };
          monospace = {
            package = pkgs.nerd-fonts.iosevka-term;
            name = "IosevkaTerm Nerd Font Mono";
          };
        };
      };
    };
}
