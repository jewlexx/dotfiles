import backup from './scoop/backup';

const args = process.argv.slice(2);

if (args[0] == 'backup') {
  await backup();
}

// Ensure this file is considered a module
export {};
