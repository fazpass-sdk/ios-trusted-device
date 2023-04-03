# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'

target 'ios-trusted-device' do
  # Comment the next line if you don't want to use dynamic frameworks
#  use_frameworks!
  use_modular_headers!
  pod 'Firebase',:modular_headers => true
  pod 'FirebaseMessaging',:modular_headers => true
  pod 'FirebaseCore',:modular_headers => true
  pod 'ReachabilitySwift',:modular_headers => true
  pod 'CryptoSwift',:modular_headers => true
  # Pods for ios-trusted-device
  target 'sample-app' do
    inherit! :search_paths
  end
end


