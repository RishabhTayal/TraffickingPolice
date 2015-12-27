platform :ios, '9.0'
use_frameworks!

# ignore all warnings from all pods
inhibit_all_warnings!

pod 'MBProgressHUD'
pod 'Parse'
pod 'ParseFacebookUtilsV4'
pod 'XLForm'
pod 'Fabric'
pod 'Crashlytics'
pod 'PulsingHalo'
pod 'UITableView-NXEmptyView'

post_install do |installer|
    installer.pods_project.targets.each do |target|
        target.build_configurations.each do |config|
            config.build_settings['EXPANDED_CODE_SIGN_IDENTITY'] = ""
            config.build_settings['CODE_SIGNING_REQUIRED'] = "NO"
            config.build_settings['CODE_SIGNING_ALLOWED'] = "NO"
        end
    end
end