source 'https://github.com/CocoaPods/Specs.git'
use_frameworks!
target 'NoneAttm' do

  
pod 'GooglePlaces'
pod 'GoogleMaps'
pod 'SwiftyJSON'
pod 'Panels'
pod 'ReachabilitySwift'
pod 'Firebase/Database'
pod 'Google-Mobile-Ads-SDK'
pod 'MarqueeLabel'
pod 'IQKeyboardManagerSwift'




end

post_install do |pi|
    pi.pods_project.targets.each do |t|
        t.build_configurations.each do |config|
            config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '12.0'
        end
    end
end


