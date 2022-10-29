import { $ } from 'zx';

const jsonOutput = await $`scoop list | ConvertTo-Json`;
