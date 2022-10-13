const cmd = process.argv.slice(3)[0];

await $`pkgfile -b -v -- "${cmd}" 2>/dev/null`;
