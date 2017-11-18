# Uncomment the next line to define a global platform for your project
platform :ios, '11.0'

target 'coins' do
  use_frameworks!

  pod 'Alamofire'
  pod 'AlamofireObjectMapper'
  pod 'ObjectMapper'
  pod 'RealmSwift'
  pod 'Charts'
  pod 'SwiftyJSON'

end

post_install do |installer|
  installer.pods_project.targets.each do |target|
    target.build_configurations.each do |config|
        config.build_settings['EXPANDED_CODE_SIGN_IDENTITY'] = ""
        config.build_settings['CODE_SIGNING_REQUIRED'] = "NO"
        config.build_settings['CODE_SIGNING_ALLOWED'] = "NO"
    end
  end
end
