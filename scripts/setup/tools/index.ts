import type { ToolInstaller } from "../installers/index.ts";
import { PacmanInstaller } from "../installers/pacman.ts";

export abstract class Tool implements ToolInstaller {
  abstract package_names: {
    pacman?: string;
    rustup?: string;
  };

  async pacman_install(): Promise<void> {
    console.log(`Installing ${this.package_names.pacman}`);
    const { success, stderr, stdout } =
      await new PacmanInstaller().install_tool(this);

    if (!success) {
      console.log(
        `Failed to install ${this.package_names.pacman}. Please install it manually.`
      );

      console.log("Installer stdout:\n", new TextDecoder().decode(stdout));
      console.log("Installer stderr:\n", new TextDecoder().decode(stderr));

      throw new Error(`Failed to install ${this.package_names.pacman}`);
    }

    this.setup();
  }

  setup(): void {}
}
