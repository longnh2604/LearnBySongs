# Uncomment the next line to define a global platform for your project
platform :ios, '9.0'

target 'LearnBySongs' do
  # Comment the next line if you're not using Swift and don't want to use dynamic frameworks
  use_frameworks!

# Workaround for Cocoapods issue #7606
post_install do |installer|
    installer.pods_project.build_configurations.each do |config|
        config.build_settings.delete('CODE_SIGNING_ALLOWED')
        config.build_settings.delete('CODE_SIGNING_REQUIRED')
    end
end

  # Pods for LearnBySongs
pod 'RevealingSplashView'
pod 'Firebase/Core'
pod 'Firebase/Auth'
pod 'Firebase/Database'
pod 'FBSDKLoginKit'
pod 'RealmSwift'
pod 'SlideMenuControllerSwift'
pod 'Parchment'
pod 'TKSubmitTransition', :git => 'https://github.com/entotsu/TKSubmitTransition.git', :branch => 'swift4'
pod 'DisplaySwitcher'
end
