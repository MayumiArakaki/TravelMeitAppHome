#
# Be sure to run `pod lib lint Home.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'Home'
  s.version          = '0.1.0'
  s.summary          = 'A short description of Home.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
TODO: Add long description of the pod here.
                       DESC

  s.homepage         = 'https://github.com/Mayumi/Home'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Mayumi' => 'mayumi.arakakisiccha@gmail.com' }
  s.source           = { :git => 'https://github.com/Mayumi/Home.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '14.0'

  s.source_files = 'Home/Classes/**/*'
  
  s.test_spec 'IntegratedTest' do |test_spec|
    test_spec.source_files = 'Home/Tests/IntegratedTests/**/*'
  end

  
  s.test_spec 'UnitTests' do |test_spec|
#    test_spec.requires_app_host = false
    test_spec.source_files = ['Home/Tests/UnitTests/**/*', 'Home/Tests/Mocks/**/*', 'Home/Tests/Spies/**/*']
  end
  
  s.dependency 'CoreEntities'
  s.dependency 'CoreBootcamp'
  
  # s.resource_bundles = {
  #   'Home' => ['Home/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end
