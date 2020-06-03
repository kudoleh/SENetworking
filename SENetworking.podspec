Pod::Spec.new do |s|
  s.name             = 'SENetworking'
  s.version          = '1.0.7'
  s.summary          = 'Simple NSURLSession wrapper'

  s.description      = <<-DESC
Simple NSURLSession wrapper
- Minimal implementation
- Super easy friendly API
- No Singletons
- No external dependencies
- Simple request cancellation
- Optimized for unit testing
- Free
                       DESC

  s.homepage         = 'https://github.com/kudoleh/SENetworking'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Oleh Kudinov' => 'oleh.kudinov@olx.com' }
  s.source           = { :git => 'https://github.com/kudoleh/SENetworking.git', :tag => s.version.to_s }

  s.swift_version = '5.0'

  s.ios.deployment_target = '9.0'
  s.osx.deployment_target = '10.11'
  s.watchos.deployment_target = '2.0'
  s.tvos.deployment_target = '9.0'

  s.source_files = 'SENetworking/Module/**/*.{swift}'

end
