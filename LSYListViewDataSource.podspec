Pod::Spec.new do |s|

  s.name         = "LSYListViewDataSource"
  s.version      = "1.0.0"
  s.summary      = "LSYListViewDataSource is a util based on MJRefresh."

  s.homepage     = "https://github.com/liusiyangiOS/LSYListViewDataSource"
  s.license      = "MIT"
  s.author       = { "liusiyangiOS" => "liusiyang_iOS@163.com" }
  
  s.ios.deployment_target = "9.0"
  s.source       = { :git => "https://github.com/liusiyangiOS/LSYListViewDataSource.git", :tag => s.version.to_s }
  s.source_files = "LSYListViewDataSource/*.{h,m}"
  s.requires_arc = true
  
  s.dependency "MJRefresh"
  
end
