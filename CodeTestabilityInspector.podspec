Pod::Spec.new do |s|
  s.name = 'CodeTestabilityInspector'
  s.version = '1.0.1'
  s.license = 'MIT'
  s.summary = 'A framework for testing the testability of Swift code.'
  s.homepage = 'https://github.com/stronv/CodeTestabilityInspector'
  s.authors = { 'Artem Tabachenko' => 'fexo5467@gmail.com' }
  
  s.source = { :git => 'https://github.com/stronv/CodeTestabilityInspector.git', :tag => s.version.to_s }
  s.source_files = 'Sources/*.swift'
  s.swift_version = '5.0'
  s.platform = :ios, '14.0'

  s.dependency 'SwiftLint'
end