#!/bin/sh

# LICENSE
#
# fastlane_config.sh is part of the GLPI API Client Library for Swift,
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

echo ----------- Create Fastlane environment variables ------------
# Create Fastlane environment variables
echo FASTLANE_PASSWORD=$FASTLANE_PASSWORD >> .env
echo TELEGRAM_WEBHOOKS=$TELEGRAM_WEBHOOKS >> .env
echo GIT_REPO="$CIRCLE_PROJECT_USERNAME/$CIRCLE_PROJECT_REPONAME" >> .env
echo GIT_BRANCH=$CIRCLE_BRANCH >> .env
echo APPLE_ID=$APPLE_ID >> .env
echo APPLE_TEAM_ID=$APPLE_TEAM_ID >> .env
echo XCODE_SCHEME=$XCODE_SCHEME >> .env
echo XCODE_PROJECT=$XCODE_PROJECT >> .env
echo XCODE_WORKSPACE=$XCODE_WORKSPACE >> .env
echo XCODE_SCHEME_DEMO=$XCODE_SCHEME_DEMO >> .env
echo APP_IDENTIFIER_DEMO=$APP_IDENTIFIER_DEMO >> .env
