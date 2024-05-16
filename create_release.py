from zipfile import ZipFile, ZIP_DEFLATED
import glob
import os
import subprocess
from datetime import datetime
from pathlib import Path
import re


ignores = [
    '.git/**/*',
    '.vscode/**/*',
    'create_release.py',
    '*.zip',
    '.gitignore',
]

ROOT = Path(__file__).parent
def rglob_files(pattern):
    return [m for m in ROOT.rglob(pattern) if m.is_file()]

files = set(rglob_files('*'))
for pattern in ignores:
    files -= set(rglob_files(pattern))

result = subprocess.run('git rev-parse --short HEAD', capture_output=True, text=True)
hash = result.stdout.strip()
major, minor = re.findall('"version":\s?\((\d+), (\d+)\)', Path('__init__.py').read_text())[0]
today = datetime.today().strftime(r'%Y-%m-%d')

package_name = f'NodeExpressions-v{major}_{minor}'
outfile = f'{package_name}-{today}-{hash}.zip'
with ZipFile(outfile, mode='w', compression=ZIP_DEFLATED, compresslevel=9) as zf:
    for f in files:
        relpath = f.relative_to(ROOT).as_posix()
        zf.write(relpath, arcname=f'{package_name}/{relpath}')

assert os.stat(outfile).st_size <= (1<<20), 'Suspicious zip size (>1MiB)'