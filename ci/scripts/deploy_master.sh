#!/bin/sh

# LICENSE
#
# deploy_master.sh is part of the GLPI API Client Library for Swift,
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
# @date      09/09/17
# @copyright Copyright © 2017-2018 Teclib. All rights reserved.
# @license   Apache License, Version 2.0 https://www.apache.org/licenses/LICENSE-2.0
# @link      https://github.com/glpi-project/swift-library-glpi
# @link      https://glpi-project.github.io/swift-library-glpi/
# @link      http://www.glpi-project.org/
# ------------------------------------------------------------------------------

GITHUB_COMMIT_MESSAGE=$(git log --format=oneline -n 1 $CIRCLE_SHA1)

if [[ $GITHUB_COMMIT_MESSAGE != *"ci(release): generate CHANGELOG.md for version"* && $GITHUB_COMMIT_MESSAGE != *"ci(build): release version"* ]]; then
    # Get gh=pages branch
    git fetch origin gh-pages
    echo "Generate CHANGELOG.md and increment version"
    # Generate CHANGELOG.md and increment version
    yarn standard-version -t '' -m "ci(release): generate CHANGELOG.md for version %s"
    # Get version number from package.json
    export GIT_TAG=$(jq -r ".version" package.json)
    
    echo "Update CHANGELOG.md on gh-pages"
    # Create header content to CHANGELOG.md
    echo "---" > header.md
    echo "layout: modal" >> header.md
    echo "title: changelog" >> header.md
    echo "---" >> header.md

    # Duplicate CHANGELOG.md
    cp CHANGELOG.md CHANGELOG_COPY.md
    # Add header to CHANGELOG.md
    (cat header.md ; cat CHANGELOG_COPY.md) > CHANGELOG.md
    # Remove CHANGELOG_COPY.md
    rm CHANGELOG_COPY.md
    rm header.md
    # Update CHANGELOG.md on gh-pages
    yarn gh-pages --dist ./ --src CHANGELOG.md --dest ./ --add -m "ci(docs): generate CHANGELOG.md for version ${GIT_TAG}"
    # Reset CHANGELOG.md
    git checkout CHANGELOG.md -f

    # Update CFBundleShortVersionString
    /usr/libexec/PlistBuddy -c "Set :CFBundleShortVersionString ${GIT_TAG}" ${PWD}/Source/Info.plist
    # Update CFBundleVersion
    /usr/libexec/PlistBuddy -c "Set :CFBundleVersion $CIRCLE_BUILD_NUM" ${PWD}/Source/Info.plist
    # Increment podspec version
    yarn podspec-bump -i ${GIT_TAG} -w
    # Add modified and delete files
    git add -u
    # Create commit
    git commit -m "ci(build): release version ${GIT_TAG}"

    # Push commits and tags to origin branch
    git push --follow-tags origin $CIRCLE_BRANCH
    echo "Create release with conventional-github-releaser"
    # Create release with conventional-github-releaser
    yarn conventional-github-releaser -p angular -t $GITHUB_TOKEN

    echo "Create Archive and ipa file"
    # Archive App and create ipa file
    bundle exec fastlane archive

    echo "Upload and create zip example code"
    # Create zip example code
    zip -r app_example_code.zip Example/*
    # Update release name
    yarn github-release edit \
    --user $CIRCLE_PROJECT_USERNAME \
    --repo $CIRCLE_PROJECT_REPONAME \
    --tag ${GIT_TAG} \
    --name "Inventory Engine v${GIT_TAG}" \
    # Upload example code release
    yarn github-release upload \
    --user $CIRCLE_PROJECT_USERNAME \
    --repo $CIRCLE_PROJECT_REPONAME \
    --tag ${GIT_TAG} \
    --name "example.zip" \
    --file app_example_code.zip
    # Upload ipa file to release
    yarn github-release upload \
    --user $CIRCLE_PROJECT_USERNAME \
    --repo $CIRCLE_PROJECT_REPONAME \
    --tag ${GIT_TAG} \
    --name "${XCODE_SCHEME_DEMO}.ipa" \
    --file "${XCODE_SCHEME_DEMO}.ipa"

    # Send untracked files to stash
    git add .
    git stash
    # Checkout to gh-pages branch
    git checkout gh-pages
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

    # Update develop branch
    git branch -D develop
    git fetch origin develop
    git checkout develop
    # # Merge master on develop
    git fetch origin master
    git rebase origin/master
    git push origin develop

    # Checkout to release branch
    git checkout $CIRCLE_BRANCH -f
    # Send app to App Store with fastlane 
    bundle exec fastlane demo
fi
