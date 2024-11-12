import type { ToolInstaller } from "../installers/index.ts";
import { Tool } from "./index.ts";

export class Zsh extends Tool implements ToolInstaller {
  package_names: { pacman: string };

  constructor() {
    super();
    this.package_names = {
      pacman: "zsh",
    };
  }
}
