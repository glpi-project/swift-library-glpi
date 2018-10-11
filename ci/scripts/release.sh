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
# @date      09/09/17
# @copyright Copyright © 2017-2018 Teclib. All rights reserved.
# @license   Apache License, Version 2.0 https://www.apache.org/licenses/LICENSE-2.0
# @link      https://github.com/glpi-project/swift-library-glpi
# @link      https://glpi-project.github.io/swift-library-glpi/
# @link      http://www.glpi-project.org/
# ------------------------------------------------------------------------------

if [[ $GITHUB_COMMIT_MESSAGE != *"ci(release): generate CHANGELOG.md for version"* && $GITHUB_COMMIT_MESSAGE != *"ci(build): release version"* ]]; then
  
  # Get old version number from package.json
  export GIT_OLD_TAG=$(jq -r ".version" package.json)
  # Generate CHANGELOG.md and increment version
  IS_PRERELEASE="$( cut -d '-' -f 2 <<< "$GIT_OLD_TAG" )";

  if [[ $GIT_TAG != "$IS_PRERELEASE" ]]; then

    PREFIX_PRERELEASE="$( cut -d '.' -f 1 <<< "$IS_PRERELEASE" )";
    yarn release -t '' --skip.bump=true -m "ci(release): generate CHANGELOG.md for version %s" --prerelease "$PREFIX_PRERELEASE"

  else

    yarn release -t '' --skip.bump=true -m "ci(release): generate CHANGELOG.md for version %s"

  fi

  # Get version number from package.json
  export GIT_TAG=$(jq -r ".version" package.json)
  echo GIT_TAG=$GIT_TAG >> .env

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
  bundle exec fastlane bump_podspec
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

    bundle exec fastlane demo
fi
