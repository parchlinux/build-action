
# building ISO
mkarchiso -v iso/ "$1"

md5hash=$(md5sum out/*.iso)

# export variables
export gh_apikey="$2"
export repo_name="$3"
export tag_name="$4"
export tag_msg=$(git tag -l $tag_name --format='%(contents)')

# Upload and Create release
python /release.py
