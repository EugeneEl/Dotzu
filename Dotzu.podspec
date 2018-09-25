Pod::Spec.new do |s|
  s.name = 'Dotzu'
  s.version = '1.7.1'
  s.license = 'MIT'
  s.summary = 'iOS debugger tool for iOS developer. Display logs, network request, device informations, crash logs while using the app.'
  s.homepage = 'https://github.com/EugeneGoloboyar/Dotzu.git'
  s.social_media_url = 'https://twitter.com/remi936'
  s.authors = { 'Rémi ROBERT' => 'remirobert33530@gmail.com' }
  s.source = { :git => 'https://github.com/EugeneGoloboyar/Dotzu.git'}
  s.ios.deployment_target = '10.0'
  s.ios.frameworks = 'UIKit', 'Foundation'
  s.source_files = 'Framework/Dotzu/Dotzu/*.swift'
  s.resources = ["Dotzu/*.storyboard", 'Dotzu/*.xcassets', 'Dotzu/*.xib']
  s.requires_arc = true
  s.swift_version = '4.0'
end
