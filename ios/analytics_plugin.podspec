#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html.
# Run `pod lib lint analytics_plugin.podspec` to validate before publishing.
#
Pod::Spec.new do |s|
  s.name             = 'analytics_plugin'
  s.version          = '0.0.1'
  s.summary          = 'A new Flutter project.'
  s.description      = <<-DESC
A new Flutter project.
                       DESC
  s.homepage         = 'http://example.com'
  s.license          = { :file => '../LICENSE' }
  s.author           = { 'Your Company' => 'email@example.com' }
  s.source           = { :path => '.' }
  s.source_files = 'Classes/**/*'
  s.dependency 'Flutter'
  s.dependency 'AWSMobileClient'
  s.dependency 'AWSPinpoint'
  s.dependency 'FBSDKCoreKit'
  s.dependency 'Rudder', '~> 2.0.1'
  #s.dependency 'RudderFirebase', '~> 1.0.0'
  s.dependency 'RudderBranch', '~> 1.0.0'
  s.platform = :ios, '13.0'

  # Flutter.framework does not contain a i386 slice.
  s.pod_target_xcconfig = { 'DEFINES_MODULE' => 'YES', 'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'i386' }
  s.swift_version = '5.0'
end
