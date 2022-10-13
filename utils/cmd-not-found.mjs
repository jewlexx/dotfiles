/**
 * @type {string}
 */
const cmd = process.argv.slice(3)[0];

const response = await $`pkgfile -b -v -- "${cmd}"`;

/**
 * @type {string}
 */
const packages = response.stdout.split('\n');

console.log(
  `The application ${cmd} is not installed. It may be found in the following packages:\n`,
);

packages.forEach((pkg) => {
  console.log(`     ${pkg}`);
});

const pkgname = packages[0].split('/')[1].split(' ')[0];

console.log(`Do you want to Install package ${pkgname}? (y/N) `);
