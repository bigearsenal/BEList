Pod::Spec.new do |s|
  s.name             = 'BEList'
  s.version          = '0.1.0'
  s.summary          = 'An easy data-driven SwiftUI List.'
  s.description      = <<-DESC
A SwiftUI List that is easy to manage and modify.
                       DESC

  s.homepage         = 'https://github.com/bigearsenal/BEList'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Chung Tran' => 'bigearsenal@gmail.com' }
  s.source           = { :git => 'https://github.com/bigearsenal/BEList.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'
  
  s.swift_versions = '5.6'

  s.ios.deployment_target = '14.0'
  s.osx.deployment_target = '12.0'
  s.tvos.deployment_target = '15.0'

  s.source_files = 'Sources/BEList/**/*'
  
  # s.resource_bundles = {
  #   'BECollectionView' => ['BECollectionView/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  s.dependency 'Introspect'
end
