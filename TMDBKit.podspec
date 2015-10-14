Pod::Spec.new do |s|
  s.name         = "TMDBKit"
  s.version      = "0.1"
  s.summary      = "Static Library for interacting with the the movie database API"

  s.description  = <<-DESC
                   DESC
  s.author       = { "Chao Ruan" => "chaoruan818@gmail.com"}
  s.platform     = :ios, '8.0'
  s.source_files  = 'TMDBKit', 'TMDBKit/**/*.{h,m}'
  s.public_header_files = 'TMDBKit/**/*.h'
  s.framework    = 'SystemConfiguration'
  s.requires_arc = true

  s.dependency 'AFNetworking'
  s.dependency 'Mantle', '2.0.2'
  s.dependency 'ReactiveCocoa', '~> 2.5'

end
