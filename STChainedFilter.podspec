Pod::Spec.new do |s|

  s.name         = "STChainedFilter"
  s.version      = "0.0.1"
  s.summary      = "A CIFilter that chained other filters"
  s.description  = "A CIFilter that chained other filters"
  s.homepage     = "https://github.com/sodastsai/chained-filter"
  s.license      = "Apache License 2.0"
  s.author       = { "sodastsai" => "sodas2002@gmail.com" }

  s.platform     = :ios, "5.0"
  s.source       = {
    :git => "https://github.com/sodastsai/chained-filter.git",
    :tag => "0.0.1"
  }

  s.source_files  = "chained-filter/**/*.{h,m}"
  s.public_header_files = "chained-filter/**/*.h"

  s.frameworks = "Foundation", "CoreImage"

  s.requires_arc = true

end
