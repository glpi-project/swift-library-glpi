#!/bin/sh

# LICENSE
#
# This file is part of the GLPI API Client Library for Swift,
# a subproject of GLPI. GLPI is a free IT Asset Management.
#
# Glpi is Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
# http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
# ------------------------------------------------------------------------------
# @author    Hector Rondon <hrondon@teclib.com>
# @date      25/08/17
# @copyright Copyright © 2017-2018 Teclib. All rights reserved.
# @license   Apache License, Version 2.0 https://www.apache.org/licenses/LICENSE-2.0
# @link      https://github.com/glpi-project/swift-library-glpi
# @link      https://glpi-project.github.io/swift-library-glpi/
# @link      http://www.glpi-project.org/
# ------------------------------------------------------------------------------

if [[ $CIRCLE_BRANCH == "develop" ]]; then

  # Get old version number from package.json
  export GIT_OLD_TAG=$(jq -r ".version" package.json)
  # Generate CHANGELOG.md and increment version
  IS_PRERELEASE="$( cut -d '-' -f 2 <<< "$GIT_OLD_TAG" )";

  if [[ $GIT_OLD_TAG != "$IS_PRERELEASE" ]]; then

    PREFIX_PRERELEASE="$( cut -d '.' -f 1 <<< "$IS_PRERELEASE" )";
    yarn release -t '' --skip.tag=true -m "ci(release): generate CHANGELOG.md for version %s" --prerelease "$PREFIX_PRERELEASE"

  else

    yarn release -t '' --skip.tag=true -m "ci(release): generate CHANGELOG.md for version %s"

  fi

fi

# Get version number from package.json
export GIT_TAG=$(jq -r ".version" package.json)

# Send untracked files to stash
git add .
git stash
# Checkout to gh-pages branch
git fetch origin gh-pages
git checkout gh-pages -f
git pull origin gh-pages

echo "Update cache"
# Create header content to cache
echo "---" > header_cache
echo "cache_version: $CIRCLE_SHA1" >> header_cache
echo "---" >> header_cache
# Remove header from file
sed -e '1,3d' sw.js > cache_file
rm sw.js
# Add new header
(cat header_cache ; cat cache_file) > sw.js
# Remove temp files
rm cache_file
rm header_cache
# Add sw.js to git
git add -u
# Create commit
git commit -m "ci(cache): force update cache for version ${GIT_TAG}"

# Push commit to origin gh-pages branch
git push origin gh-pages