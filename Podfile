platform :ios, '16.0'

target 'parseTemplate' do
  use_frameworks!

  pod 'Parse'
  pod 'Kingfisher'
end

post_install do |installer|
  installer.generated_projects.each do |project|
    project.targets.each do |target|
      target.build_configurations.each do |config|
        config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '16.0'
      end
    end
  end
end