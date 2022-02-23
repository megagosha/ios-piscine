#
# Be sure to run `pod lib lint edebi2022.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'edebi2022'
  s.version          = '0.2.1'
  s.summary          = 'This is first pod created by edebi.'
  s.swift_version    = '5.2'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

s.description      = <<-DESC
I dont know what I have to do yet. So I decided to generate some words to fill up space.
                       DESC

                       
  s.homepage         = 'https://github.com/George/edebi2022'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'George' => 'megagosha@gmail.com' }
  s.source           = { :git => 'https://github.com/George/edebi2022.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '15.2'

  s.source_files = 'Classes/**/*'
  s.resource = 'Assets/*'
  # s.resource_bundles = {
  #   'edebi2022' => ['edebi2022/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end
