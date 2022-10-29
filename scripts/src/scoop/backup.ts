import { $ } from 'zx';
import fs from 'fs';

import { Convert as PackageConvert } from './packages';
import { Convert as BucketConvert } from './buckets';

const pkgsJsonOutput = await $`scoop list | ConvertTo-Json`;

const packages = PackageConvert.toPackages(pkgsJsonOutput.stdout);

const packageBackup = packages.map((pkg) => pkg.Name).join('\n');

fs.writeFileSync('../scoop-packages.txt', packageBackup);

const bucketsJsonOutput = await $`scoop bucket list | ConvertTo-Json`;

const buckets = BucketConvert.toBuckets(pkgsJsonOutput.stdout);

const bucketsBackup = packages
  .map((bucket) => `${bucket.Name} ${bucket.Source}`)
  .join('\n');

fs.writeFileSync('../scoop-packages.txt', packageBackup);

fs.writeFileSync('../scoop-buckets.txt', bucketsBackup);
