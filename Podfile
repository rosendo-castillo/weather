platform :ios, '11.0'

# ignore all warnings from all pods
inhibit_all_warnings!

use_frameworks!

def nearbyweather_pods
    pod 'PKHUD', '~> 5.3'
    pod 'TextFieldCounter', '~> 1.1'
    pod 'Alamofire', '~> 5.2'
    pod 'APTimeZones', '~> 1.1'
    pod 'FMDB', '~> 2.7'

    pod 'RxSwift', '~> 5.1'
    pod 'RxCocoa', '~> 5.1'
    pod 'RxFlow', '~> 2.9'

    pod 'SwiftLint', '~> 0.40'
    pod 'R.swift', '5.2'

    pod 'Firebase/Analytics', '~> 6.31'
    pod 'Firebase/Crashlytics', '~> 6.31'
end

target 'NearbyWeather' do
    nearbyweather_pods
end  

target 'NearbyWeatherTests' do
    nearbyweather_pods
end

post_install do |installer|
  installer.pods_project.targets.each do |target|
    target.build_configurations.each do |config|
      next if config.name.downcase.include? 'debug'
      config.build_settings['ENABLE_BITCODE'] = 'YES'
      cflags = config.build_settings['OTHER_CFLAGS'] || ['$(inherited)']
      cflags << '-fembed-bitcode'
      config.build_settings['OTHER_CFLAGS'] = cflags
    end
  end
end
