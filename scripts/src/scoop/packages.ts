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
