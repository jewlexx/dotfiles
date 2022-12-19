import { $ } from 'zx';

$.shell = 'pwsh.exe';

import fs from 'fs/promises';

import { Convert as PackageConvert } from './packages';
import { Convert as BucketConvert } from './buckets';

export default async function backup() {
  const pkgsJsonOutput = await $`scoop list | ConvertTo-Json`;

  const packages = PackageConvert.toPackages(pkgsJsonOutput.stdout);

  const packageBackup = packages.map((pkg) => pkg.Name);

  const bucketsJsonOutput = await $`scoop bucket list | ConvertTo-Json`;

  const buckets = BucketConvert.toBuckets(bucketsJsonOutput.stdout);

  const bucketsBackup = buckets.map((bucket) => ({
    name: bucket.Name,
    url: bucket.Source,
  }));

  await fs.writeFile(
    '../scoop-packages.json',
    JSON.stringify(packageBackup, null, 4),
  );

  await fs.writeFile(
    '../scoop-buckets.json',
    JSON.stringify(bucketsBackup, null, 4),
  );
}
