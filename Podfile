# Uncomment the next line to define a global platform for your project
 platform :ios, '16.4'

def test_pods
  pod 'Quick', '5.0.1'
  pod 'Nimble', '10.0.0'
  pod 'Nimble-Snapshots', '9.4.0'
end

target 'Github' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!

  # Pods for Github
  pod 'SDWebImage'
  
  target 'GithubTests' do
    inherit! :search_paths
    test_pods
    # Pods for testing
  end

  target 'GithubUITests' do
    # Pods for testing
    test_pods

  
  end
  
end
