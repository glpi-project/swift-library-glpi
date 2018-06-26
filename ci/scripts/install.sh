#!/bin/sh

# LICENSE
#
# install.sh is part of the GLPI API Client Library for Swift,
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
# @copyright (C) 2017 Teclib' and contributors
# @license   Apache License, Version 2.0 https://www.apache.org/licenses/LICENSE-2.0
# @link      https://github.com/flyve-mdm/ios-library-glpi
# @link      http://www.glpi-project.org/
# ------------------------------------------------------------------------------

# Update gem
gem update --system
# Clean Gem
gem cleanup
# Install jazzy for generate documentation
gem install jazzy
# Install bundler last version
gem install bundler
# Install node
brew install node
# Install jq for json parse
brew install jq
# Install carthage
brew install carthage
# Install standard-version scope global
npm i -g standard-version
# Install conventional-github-releaser scope global
npm install -g conventional-github-releaser
# Install podspec-bump for increment podspec version
npm install -g podspec-bump
# Install node-github-release to create and edit releases on Github
npm install -g node-github-release
# Install libs from package.json
npm install
# Install gems from Gemfile
bundle install --path vendor/bundle
# Update fastlane plugin
bundle exec fastlane update_plugins
