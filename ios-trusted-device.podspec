Pod::Spec.new do |spec|

  spec.name         = "ios-trusted-device"
  spec.version      = "0.0.4"
  spec.summary      = "A CocoaPods library for implementation trusted device from fazpass"

  spec.description  = <<-DESC
This library include some feature like;
- OTP
- Header Enrichment
- Trusted Device
                   DESC

  spec.homepage     = "https://github.com/fazpass-sdk/ios-trusted-device"
  spec.license      = { :type => "MIT", :file => "LICENSE" }
  spec.author       = { "anvarisy" => "anvarisy@gmail.com" }

  spec.ios.deployment_target = "15.0"
  spec.swift_version = "4.2"

  spec.source        = { :git => "https://github.com/fazpass-sdk/ios-trusted-device.git", :tag => "#{spec.version}" }
  spec.source_files  = "ios-trusted-device/**/*.{h,m,swift}"

  spec.dependency 'CryptoSwift', '~> 1.7'
  spec.dependency 'Firebase', '~> 9.6'
end