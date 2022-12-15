$.verbose = false;

/**
 * @type {string}
 */
const cmd = process.argv.slice(3)[0];

const response = await $`pkgfile -b -v -- "${cmd}"`.catch(() => {
  console.log(`zsh: command not found: ${cmd}`);
  process.exit(1);
});

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

/**
 * @type {string}
 */
const install = await question(
  `Do you want to Install package ${pkgname}? (y/N) `,
);

if (install.toLowerCase() === 'y') {
  await $`sudo pacman -S ${pkgname}`;
} else {
  process.exit(1);
}
