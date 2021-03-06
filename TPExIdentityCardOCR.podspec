#
# Be sure to run `pod lib lint TPExIdentityCardOCR.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
s.name             = 'TPExIdentityCardOCR'
s.version          = '1.0.8'
s.summary          = '易道博识身份证扫描(tiny的js扩展)'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

s.description      = <<-DESC
TODO:     pod 'TPExIdentityCardOCR'
DESC

s.homepage         = 'https://github.com/TinySunline/TPExIdentityCardOCR'
# s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
s.license          = { :type => 'MIT', :file => 'LICENSE' }
s.author           = { 'kingdomrain' => 'bygd2014@sina.com' }
s.source           = { :git => 'https://github.com/TinySunline/TPExIdentityCardOCR.git'}
# s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

s.ios.deployment_target = '7.0'

s.source_files = 'TPExIdentityCardOCR/Classes/**/*'

s.resource_bundles = {'TPExIdentityCardOCR' => ['TPExIdentityCardOCR/Assets/ExCardRes.bundle']}

#s.vendored_frameworks = 'Pod/sdk/ExCardSDK.framework'
s.vendored_frameworks = 'TPExIdentityCardOCR/Assets/ExCardSDK.framework'

# s.public_header_files = 'Pod/Classes/**/*.h'
# s.frameworks = 'UIKit', 'MapKit'
# s.dependency 'AFNetworking', '~> 2.3'
end


