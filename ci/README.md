# Continuous Integration with Circle CI script and files 

Here is placed files and bash script required to build, test and deploy the app with Circle CI

## Workflow description:

#### On machine

- Configure environment variables
- Use xcode 9.0

#### On checkout

- Update git tags

#### On dependencies

- Configure bundler (scripts/bundler_config.sh)
- install dependencies for deploy (scripts/install.sh)

#### On test

- Configure fastlane environment variables (scripts/fastlane_config.sh)
- Global configuration git (scripts/git_config.sh)
- Run Build on feature branch or run test on develop or master branch (scripts/test.sh)

#### On deploy_develop

- Generate new tag with standard-version (scripts/deploy_develop.sh)
- Update version and build (scripts/deploy_develop.sh)
- Generate documentation with jazzy (scripts/deploy_develop.sh)
- Generate code coverage reporting with xcov (scripts/deploy_develop.sh)

#### On deploy_master

- Generate new tag with standard-version (scripts/deploy_master.sh)
- Update version and build (scripts/deploy_master.sh)
- Create a github release (scripts/deploy_master.sh)
- Update CHANGELOG.md on gh-pages branch (scripts/deploy_master.sh)
- Push new version cocoapods (scripts/pod_trunk_push.sh)
