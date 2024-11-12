import { Installer, type ToolInstaller } from "./index.ts";

export class PacmanInstaller extends Installer {
  install_tool(tool: ToolInstaller): Promise<Deno.CommandOutput> {
    console.log("Installing tool", tool.package_names.pacman);
    const installer = new Deno.Command("sudo", {
      args: ["pacman", "-S", tool.package_names.pacman!, "--noconfirm"],
      stdout: "piped",
      stderr: "piped",
      stdin: "inherit",
    });

    return installer.output();
  }
}
