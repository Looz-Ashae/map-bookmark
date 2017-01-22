platform :ios, '9.0'
use_frameworks!

target 'map-bookmark' do
	pod 'Swinject', '~> 1.1'
	pod 'PureLayout'
	pod 'LGPlusButtonsView', :git => 'https://github.com/Looz-Ashae/LGPlusButtonsView'
	pod 'RealmSwift'
	pod 'PromiseKit', '~> 3.5'
	pod 'Mapbox-iOS-SDK'
    pod 'MGSwipeTableCell', '~> 1.5'
    pod 'SwiftLocation', :git => 'https://github.com/malcommac/SwiftLocation/', :branch => 'swift2.3'
   end

post_install do |installer|
  installer.pods_project.targets.each do |target|
    target.build_configurations.each do |config|
      config.build_settings['SWIFT_VERSION'] = '2.3' # or '3.0'
    end
  end
end