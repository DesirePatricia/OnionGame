# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'

target 'OnionGame' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!

  # Pods for OnionGame
pod 'Firebase'
pod 'Firebase/Core'
pod 'Firebase/Auth'
pod 'Firebase/Database'
pod 'Google-Mobile-Ads-SDK'
pod 'GoogleAnalytics'
post_install do |installer|
  installer.pods_project.targets.each do |target|
  if target.name == 'GeoFire' then
    target.build_configurations.each do |config|
      config.build_settings['FRAMEWORK_SEARCH_PATHS'] = "#{config.build_settings['FRAMEWORK_SEARCH_PATHS']} ${PODS_ROOT}/FirebaseDatabase/Frameworks/ $PODS_CONFIGURATION_BUILD_DIR/GoogleToolboxForMac $PODS_CONFIGURATION_BUILD_DIR/nanopb"
      config.build_settings['OTHER_LDFLAGS'] = "#{config.build_settings['OTHER_LDFLAGS']} -framework FirebaseDatabase"
    			end
 	 	end
	end

end
end