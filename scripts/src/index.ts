import backup from './scoop/backup';
import setup from './setup';

const args = process.argv.slice(2);

(async () => {
  const cmd = args[0];

  if (cmd == 'backup') {
    await backup();
  } else if (cmd == 'setup') {
  }
})();
