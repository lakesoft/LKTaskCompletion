Pod::Spec.new do |s|
  s.name         = "LKTaskCompletion"
  s.version      = "1.0.0"
  s.summary      = "Task Completion Utility"
  s.description  = <<-DESC
Task Completion Utility.
                   DESC
  s.homepage     = "https://github.com/lakesoft/LKTaskCompletion"
  s.license      = { :type => 'MIT', :file => 'LICENSE' }
  s.author       = { "Hiroshi Hashiguchi" => "xcatsan@mac.com" }
  s.source       = { :git => "https://github.com/lakesoft/LKTaskCompletion", :tag => s.version.to_s }

  s.platform     = :ios, '7.0'
  s.requires_arc = true

  s.source_files = 'Classes/*'

 end

