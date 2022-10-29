export interface Buckets {
  Name: string;
  Source: string;
  Updated: Date;
  Manifests: number;
}

// Converts JSON strings to/from your types
export class Convert {
  public static toBuckets(json: string): Buckets[] {
    return JSON.parse(json);
  }

  public static bucketsToJson(value: Buckets[]): string {
    return JSON.stringify(value);
  }
}
