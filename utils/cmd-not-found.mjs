/**
 * @type {string}
 */
const cmd = process.argv.slice(3)[0];

const response = await $`pkgfile -b -v -- "${cmd}"`;

/**
 * @type {string}
 */
const packages = response.stdout;

console.log(
  `The application ${cmd} is not installed. It may be found in the following packages:\n`,
);
