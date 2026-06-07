{ pkgs, ... }: {
  programs.git = {
    enable = true;

    settings = {
      user = {
        name = "Leopold Sprenger";
        email = "186564656+leopoldsprenger@users.noreply.github.com";
      };
      push.autoSetupRemote = true;
      init.defaultBranch = "main";
    };

    ignores = pkgs.lib.splitString "\n" (builtins.readFile ../resources/git/gitignore_global);
  };

  programs.delta = {
    enable = true;
    enableGitIntegration = true;
    options = {
      navigate = true;
      light = false;
      side-by-side = true;
    };
  };
}
