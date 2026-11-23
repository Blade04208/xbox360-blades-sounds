import { execFileSync } from 'node:child_process';
import { mkdir, rm } from 'node:fs/promises';
import { createRequire } from 'node:module';
import { join } from 'node:path';
import { fileURLToPath } from 'node:url';

const root = fileURLToPath(new URL('../', import.meta.url));
const output = join(root, 'dist');
const require = createRequire(import.meta.url);
const starlight = require.resolve('@steambrew/starlight/bin/starlight.js');

await mkdir(output, { recursive: true });
await rm(join(output, 'x360-blades-sounds.star'), { force: true });
execFileSync(process.execPath, [
  starlight,
  '--dir', root,
  '--of', output,
  '--release',
  'pack',
], { cwd: root, stdio: 'inherit' });
