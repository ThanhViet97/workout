# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'

target 'Workout' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!

  # Pods for Workout
  pod 'Alamofire'
  pod 'Swinject'
  
  target 'WorkoutTests' do
    inherit! :search_paths
    # Pods for testing
  end

  target 'WorkoutUITests' do
    # Pods for testing
  end
  
  post_install do |installer_representation|
      installer_representation.pods_project.targets.each do |target|
          target.build_configurations.each do |config|
              config.build_settings['ALWAYS_EMBED_SWIFT_STANDARD_LIBRARIES'] = '$(inherited)'
          end
      end
  end
end
