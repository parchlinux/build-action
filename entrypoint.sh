#!/bin/bash

# building ISO
mkarchiso -v iso/ $archiso_options

md5hash=$(md5sum out/*.iso)

export tag_msg=$(git tag -l $tag_name --format='%(contents)')

# Upload and Create release
python /release.py
