Pod::Spec.new do |s|
  s.name         = 'SListView'
  s.version      = '0.0.1'
  s.summary      = 'Swift list view component.'
  s.description  = <<-DESC
    SListView is an easy to use iOS list collection. Don't spend hours writing your code to display lists!
  DESC
  s.homepage     = 'https://github.com/shial4/SLazeKit.git'
  s.license      = { :type => 'MIT', :file => 'LICENSE' }
  s.author             = { 'Szymon Lorenz' => 'shial184686@gmail.com' }
  s.social_media_url   = 'https://twitter.com/shial_4'
  
  s.ios.deployment_target = '10.0'

  s.source       = { :git => 'https://github.com/shial4/SListView.git', :tag => s.version.to_s }
  s.source_files  = 'Sources/**/*.swift'
  s.frameworks  = 'UIKit'

end