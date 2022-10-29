import { $ } from 'zx';

$.shell = 'pwsh.exe';

import fs from 'fs/promises';

import { Convert as PackageConvert } from './packages';
import { Convert as BucketConvert } from './buckets';

export default async function backup() {
  const pkgsJsonOutput = await $`scoop list | ConvertTo-Json`;

  const packages = PackageConvert.toPackages(
    pkgsJsonOutput.stdout.split('\n').slice(1).join('\n'),
  );

  const packageBackup = packages.map((pkg) => pkg.Name).join('\n');

  const bucketsJsonOutput = await $`scoop bucket list | ConvertTo-Json`;

  const buckets = BucketConvert.toBuckets(bucketsJsonOutput.stdout);

  const bucketsBackup = buckets
    .map((bucket) => `${bucket.Name} ${bucket.Source}`)
    .join('\n');

  await fs.writeFile('../scoop-packages.txt', packageBackup);

  await fs.writeFile('../scoop-buckets.txt', bucketsBackup);
}
