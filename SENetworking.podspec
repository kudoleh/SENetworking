Pod::Spec.new do |s|
  s.name             = 'SENetworking'
  s.version          = '1.0.0'
  s.summary          = 'A short description of Networking.'

  s.description      = <<-DESC
Simple NSURLSession wrapper with support
- Minimal implementation
- Super easy friendly API
- No Singletons
- No external dependencies
- Simple request cancellation
- Optimized for unit testing
- Free
                       DESC

  s.homepage         = 'https://github.com/Oleh Kudinov/SENetworking'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Oleh Kudinov' => 'oleh.kudinov@olx.com' }
  s.source           = { :git => 'https://github.com/Oleh Kudinov/Networking.git', :tag => s.version.to_s }

  s.ios.deployment_target = '10.0'

  s.source_files = 'SENetworking/Module/**/*.{swift}'
  
  s.resources = 'SENetworking/Module/**/*.{xcassets,json,storyboard,xib,xcdatamodeld}'

  s.test_spec 'Tests' do |test_spec|
    test_spec.source_files = 'SENetworking/Tests/**/*.{swift}'
  end

end