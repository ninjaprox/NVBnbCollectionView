Pod::Spec.new do |s|
  s.name         = "NVBnbCollectionView"
  s.version      = "1.0.1"
  s.summary      = "An Airbnb-inspired collection view"
  s.homepage     = "https://github.com/ninjaprox/NVBnbCollectionView"
  s.screenshots  = ["https://raw.githubusercontent.com/ninjaprox/NVBnbCollectionView/master/Demo-portrait.gif",
                    "https://raw.githubusercontent.com/ninjaprox/NVBnbCollectionView/master/Demo-landscape.gif"]       
  s.license      = { :type => "MIT" }
  s.author             = { "Nguyen Vinh" => "ninjaprox@gmail.com" }
  s.social_media_url   = "http://twitter.com/ninjaprox"

  s.platform     = :ios, '7.0'

  s.source       = { :git => "https://github.com/ninjaprox/NVBnbCollectionView.git", :tag => "v1.0.0" }
  s.source_files  = "NVBnbCollectionView/*.{h,m}"

  s.frameworks = "UIKit"
  s.requires_arc = true
end
