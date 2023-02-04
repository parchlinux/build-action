
# building ISO
mkarchiso -v iso/ "${{ inputs.archiso_options }}"

md5hash=$(md5 out/*.iso)

# export variables
export gh_apikey="${{ inputs.gh_apikey }}"
export repo_name="${{ inputs.repo_name }}"
export tag_name="${{ inputs.release_tag_name }}"
export tag_msg=$(git tag -l $tag_name --format='%(contents)')

# Upload and Create release
python /upload_assest.py
