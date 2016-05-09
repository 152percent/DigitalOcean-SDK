Pod::Spec.new do |s|
  s.name             = "DigitalOcean"
  s.version          = "1.0"
  s.summary          = "An Digitial Ocean SDK for iOS and OSX"
  s.homepage         = "https://github.com/shaps80/DigitalOcean-SDK"
  s.license          = 'MIT'
  s.author           = { "Shaps" => "http://shaps.me" }
  s.source           = { :git => "https://github.com/shaps80/DigitalOcean-SDK.git", :tag => s.version.to_s }
  s.social_media_url = "https://twitter.com/shaps"
  s.platform = :ios, "7.0"
  s.platform = :osx, "10.9"
  s.ios.deployment_target = "7.0"
  s.osx.deployment_target = "10.9"
  s.requires_arc = true
  s.source_files = 'Pod/Classes/**/*.{h,m}'
  s.dependency 'SPXDefines', '~> 1.2'
end
