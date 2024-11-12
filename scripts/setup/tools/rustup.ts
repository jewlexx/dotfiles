import type { ToolInstaller } from "../installers/index.ts";
import { Tool } from "./index.ts";

export class Rustup extends Tool implements ToolInstaller {
  package_names: { pacman: string };

  constructor() {
    super();
    this.package_names = {
      pacman: "rustup",
    };
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
