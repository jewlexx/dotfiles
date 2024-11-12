import type { ToolInstaller } from "../installers/index.ts";
import { PacmanInstaller } from "../installers/pacman.ts";
import { Tool } from "./index.ts";

export class Rustup extends Tool implements ToolInstaller {
  package_names: { pacman: string };

  constructor() {
    super();
    this.package_names = {
      pacman: "rustup",
    };
  }

  async pacman_install(): Promise<void> {
    console.log("Installing rustup");
    const { success } = await new PacmanInstaller().install_tool(this);

    if (!success) {
      console.log("Failed to install rustup. Please install it manually.");
      throw new Error("Failed to install rustup");
    }

    this.setup();
  }

  override setup(): void {
    console.log("Setting up rustup");

    const installer = new RustupInstaller();

    installer.install_toolchain(Toolchain.Stable);
    installer.install_toolchain(Toolchain.Nightly);

    console.log("Rustup setup complete");
  }
}

enum Toolchain {
  Stable = "stable",
  Nightly = "nightly",
}

export class RustupInstaller {
  install_toolchain(toolchain: Toolchain): Promise<Deno.CommandOutput> {
    console.log("Installing toolchain", toolchain);
    const installer = new Deno.Command("rustup", {
      args: ["install", toolchain.toString()],
      stdout: "piped",
      stderr: "piped",
    });

    return installer.output();
  }
}
