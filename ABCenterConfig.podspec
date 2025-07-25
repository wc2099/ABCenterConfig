#
# Be sure to run `pod lib lint ABCenterConfig.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'ABCenterConfig'
  s.version          = '0.1.0'
  s.summary          = 'A short description of ABCenterConfig.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
TODO: Add long description of the pod here.
                       DESC

  s.homepage         = 'https://codearts.af-south-1.huaweicloud.com/codehub/project/006f03b6050f4c22a993b2c1632a66a2/codehub/2493629/home?ref=master'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Jack.cai' => 'Jackcai@emobility.com.ng' }
  s.source           = { :git => 'git@repo.codearts.af-south-1.huaweicloud.com:006f03b6050f4c22a993b2c1632a66a2/Mobile/emobility/iOS/ABCenterConfig.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '15.0'  
  # s.resource_bundles = {
  #   'ABCenterConfig' => ['ABCenterConfig/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
  s.subspec 'Config' do |config|
    config.source_files = 'ABCenterConfig/Classes/Config/**/*'
  end
  
  s.dependency 'Firebase/RemoteConfig', '11.8.0'
end
