#!/usr/bin/env python

import os
import hashlib

from pathlib import Path
from urllib import request

def save_to_tempfile(url: str):
    p = Path(f'/tmp/{hashlib.sha256(url.encode()).hexdigest()}')
    abs_path = p.absolute()
    if not p.exists():
        with open(abs_path, 'wb') as f:
            f.write(request.urlopen(url).read())
    return abs_path

file_name = save_to_tempfile("https://source.unsplash.com/featured/3840x2160/daily/?cat")
os.system(f'/usr/bin/env feh --bg-scale {file_name}')
