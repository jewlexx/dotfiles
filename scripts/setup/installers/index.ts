export interface ToolInstaller {
  package_names: {
    pacman?: string;
    rustup?: string;
  };
}

export abstract class Installer {
  abstract install_tool(tool: ToolInstaller): Promise<Deno.CommandOutput>;
}
