import backup from './scoop/backup';

const args = process.argv.slice(2);

(async () => {
  if (args[0] == 'backup') {
    await backup();
  }
})();
