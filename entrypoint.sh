#!/bin/bash

mkarchiso -v iso/ $archiso_options

pwd
ls

md5hash=$(md5sum out/*.iso) || exit $?

export tag_msg=$(git tag -l $tag_name --format='%(contents)')

# Upload and Create release
python /release.py || exit $?
