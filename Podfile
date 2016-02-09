platform :ios, '9.0'
use_frameworks!

# ignore all warnings from all pods
inhibit_all_warnings!

pod 'MBProgressHUD'
#pod 'Parse'
#pod 'ParseFacebookUtilsV4'
pod 'XLForm'
pod 'Fabric'
pod 'Crashlytics'
pod 'PulsingHalo'
pod 'UITableView-NXEmptyView'
pod 'AFNetworking'

post_install do |installer|
    installer.pods_project.targets.each do |target|
        target.build_configurations.each do |config|
            config.build_settings['EXPANDED_CODE_SIGN_IDENTITY'] = ""
            config.build_settings['CODE_SIGNING_REQUIRED'] = "NO"
            config.build_settings['CODE_SIGNING_ALLOWED'] = "NO"
        end
    end
    
    #This system sets the version of facebook pods to non beta versions. it was causing error in submitting to app store.
    app_plist = "TraffickingPolice/Info.plist"
    plist_buddy = "/usr/libexec/PlistBuddy"
    
    version = `#{plist_buddy} -c "Print CFBundleShortVersionString" "#{app_plist}"`.strip
    
    puts "Updating CocoaPods frameworks' version numbers to #{version}"
    
    installer.pods_project.targets.each do |target|
        `#{plist_buddy} -c "Set CFBundleShortVersionString #{version}" "Pods/Target Support Files/#{target}/Info.plist"`
    end
    
    
end