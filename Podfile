platform :ios, '14.2'

target 'Trackizer' do
  use_frameworks!
	
  	pod 'FirebaseCore'
  	pod 'FirebaseAuth'
	pod 'FirebaseFirestore'
	pod 'FirebaseStorage'	
	pod 'DropDown'
	pod 'DGCharts'
end

post_install do |installer|
    installer.generated_projects.each do |project|
        project.targets.each do |target|
            target.build_configurations.each do |config|
                config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '14.2'
            end
        end
    end
end