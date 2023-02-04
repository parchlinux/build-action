import logging
import os
import sys
from datetime import datetime
from pathlib import Path

from github import Github, Repository, GitRelease

gh_apikey = os.getenv("gh_apikey")
repo_name = os.getenv("repo_name")
tag_name = os.getenv("tag_name")
tag_message = os.getenv("tag_msg")
iso_hash = os.getenv("md5hash").split(" ")  # [0]: name, [1]: md5 hash

release_msg = f"""
# {tag_name}

{tag_message}

| name | md5 |
|------|-----|
| {iso_hash[0]} | {iso_hash[1]} |
"""

logging.basicConfig(level=logging.INFO, format="%(levelname)s: %(message)s")


def create_release(
    tag: str, msg: str, repo: Repository, prerelease: bool = False
) -> GitRelease:
    return repo.create_git_release(
        tag=tag, name=tag, message=msg, prerelease=prerelease
    )


current_date = datetime.today().strftime("%Y-%m-%d")
path = list(Path().cwd().glob("out/*.iso"))[0].as_posix()
logging.info("Starting at %s", current_date)

gh = Github(gh_apikey)
repo = gh.get_repo(f"parchlinux/{repo_name}")
release = create_release(tag=tag_name, msg=release_msg, repo=repo)

logging.info("statrting Upload ISO to release")

try:
    release.upload_asset(path=path)
except:
    logging.warn("ISO uploading is faild. trying again...")
    release.upload_asset(path=path)
finally:
    logging.info("ISO upload is done")
