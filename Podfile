# Uncomment the next line to define a global platform for your project
platform :ios, '12.0'

# Base Pods
def base_pods
  pod 'Alamofire', '~> 5.2'
  pod 'Moya/RxSwift', '~> 15.0'
  pod 'RxCocoa', '6.2.0'
  pod 'CocoaLumberjack/Swift'
  pod 'Kingfisher', '~> 7.0'
end

target 'WBooks' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!

  # Pods for WBooks
  base_pods

  target 'WBooksTests' do
    inherit! :search_paths
    # Pods for testing
  end

  target 'WBooksUITests' do
    # Pods for testing
  end

end
