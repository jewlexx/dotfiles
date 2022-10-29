import { $ } from 'zx';
import fs from 'fs';

export interface Packages {
  Version: string;
  Source: string;
  Info: string;
  Name: string;
  Updated: Date;
}

// Converts JSON strings to/from your types
export class Convert {
  public static toPackages(json: string): Packages[] {
    return JSON.parse(json);
  }

  public static packagesToJson(value: Packages[]): string {
    return JSON.stringify(value);
  }
}

const jsonOutput = await $`scoop list | ConvertTo-Json`;

const packages = Convert.toPackages(jsonOutput.stdout);

const packageBackup = packages.map((pkg) => pkg.Name).join('\n');

fs.writeFileSync('../scoop-packages.txt', packageBackup);
