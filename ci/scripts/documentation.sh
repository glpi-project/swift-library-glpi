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

if [[ $GITHUB_COMMIT_MESSAGE != *"ci(release): generate CHANGELOG.md for version"* && $GITHUB_COMMIT_MESSAGE != *"ci(build): release version"* ]]; then

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
  # Update CFBundleShortVersionString
  /usr/libexec/PlistBuddy -c "Set :CFBundleShortVersionString ${GIT_TAG}" ${PWD}/Source/Info.plist
  # Update CFBundleVersion
  /usr/libexec/PlistBuddy -c "Set :CFBundleVersion $CIRCLE_BUILD_NUM" ${PWD}/Source/Info.plist
  # Add modified and delete files
  git add ${PWD}/Source/Info.plist
  git commit --amend --no-edit

  echo "Generate documentation with jazzy"
  # Generate documentation with jazzy
  bundle exec jazzy
  mv docs/ code-documentation/  
  # Add docs folder
  git add code-documentation -f
  # Create commit, NOTICE: this commit is not sent
  git commit -m "ci(docs): generate **docs** for version ${GIT_TAG}"
  # Update documentation on gh-pages branch
  yarn gh-pages --dist code-documentation --dest "${DOCUMENTATION_DESTINATION}${CIRCLE_BRANCH}" -m "ci(docs): generate documentation with jazzy for version ${GIT_TAG}"

fi
