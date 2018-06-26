#!/bin/sh

# LICENSE
#
# deploy_develop.sh is part of the GLPI API Client Library for Swift,
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
# @date      08/09/17
# @copyright Copyright © 2017-2018 Teclib. All rights reserved.
# @license   Apache License, Version 2.0 https://www.apache.org/licenses/LICENSE-2.0
# @link      https://github.com/glpi-project/swift-library-glpi
# @link      https://glpi-project.github.io/swift-library-glpi/
# @link      http://www.glpi-project.org/
# ------------------------------------------------------------------------------

GITHUB_COMMIT_MESSAGE=$(git log --format=oneline -n 1 $CIRCLE_SHA1)

if [[ $GITHUB_COMMIT_MESSAGE != *"ci(release): generate CHANGELOG.md for version"* && $GITHUB_COMMIT_MESSAGE != *"ci(build): release version"* ]]; then
    echo "Generate CHANGELOG.md and increment version"
    # Get gh=pages branch
    git fetch origin gh-pages
    # Generate CHANGELOG.md and increment version
    yarn standard-version -- -t ''
    # Get version number from package.json
    export GIT_TAG=$(jq -r ".version" package.json)
    # Update CFBundleShortVersionString
    /usr/libexec/PlistBuddy -c "Set :CFBundleShortVersionString ${GIT_TAG}" ${PWD}/Source/Info.plist
    # Update CFBundleVersion
    /usr/libexec/PlistBuddy -c "Set :CFBundleVersion $CIRCLE_BUILD_NUM" ${PWD}/Source/Info.plist
    # Add modified and delete files
    git add Source/Info.plist
    # Create commit
    git commit -m "ci(beta): generate **beta** for version ${GIT_TAG}"

    echo "Generate documentation with jazzy"
    # Generate documentation with jazzy
    jazzy
    mv docs/ code-documentation/  
    # Add docs folder
    git add code-documentation -f
    # Create commit, NOTICE: this commit is not sent
    git commit -m "ci(docs): generate **docs** for version ${GIT_TAG}"
    # Update documentation on gh-pages branch
    yarn gh-pages --dist code-documentation --dest development/code-documentation -m "ci(docs): generate documentation with jazzy for version ${GIT_TAG}"

    echo "Generate code coverage reporting with xcov"
    # Generate code coverage reporting with xcov
    bundle exec fastlane coverage

    # Add coverage folder
    git add coverage -f
    # Create commit, NOTICE: this commit is not sent
    git commit -m "ci(docs): generate **coverage** for version ${GIT_TAG}"
    # Update coverage on gh-pages branch
    yarn gh-pages --dist coverage --dest development/coverage -m "ci(docs): generate coverage with xcov for version ${GIT_TAG}"

    echo "Generate test report"
    # Create header content to test report
    echo "---" > header.html
    echo "layout: modal" >> header.html
    echo "---" >> header.html

    # Add header to test report
    (cat header.html ; cat fastlane/test_output/report.html) > fastlane/test_output/index.html
    # Remove test report copy
    rm fastlane/test_output/report.html
    rm header.html

    # Generate test report
    yarn gh-pages --dist fastlane/test_output --src index.html --dest development/test-reports -m "ci(docs): generate test report for version ${GIT_TAG}" 

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

    git checkout $CIRCLE_BRANCH -f
fi
