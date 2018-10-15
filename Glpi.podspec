Pod::Spec.new do |s|
  s.name                  = 'swift-library-glpi'
  s.version               = '0.0.1'
  s.license               = { :type => "Apache License, Version 2.0", :file => "LICENSE.md" }
  s.summary               = 'GLPI APIs Client Library for Swift for REST'
  s.homepage              = 'http://www.glpi-project.org/'
  s.social_media_url      = 'https://twitter.com/FlyveMDM'
  s.authors               = { "Flyve MDM" => "apple@teclib.com", "Hector Rondon" => "hrondon@teclib.com" }
  s.source                = { :git => "https://github.com/glpi-project/swift-library-glpi.git", :tag => s.version }
  s.source_files          = 'Source/*.{swift,h,m}'
  s.platforms             = { :ios => "10.3" }
  s.pod_target_xcconfig   = { 'SWIFT_VERSION' => '4.2' }
end
