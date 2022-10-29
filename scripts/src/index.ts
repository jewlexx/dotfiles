const args = process.argv.slice(2);

if (args[0] == 'backup') {
  await import('./scoop/backup');
}

// Ensure this file is considered a module
export {};
