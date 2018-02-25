#
#  Be sure to run `pod spec lint HePaiPay.podspec' to ensure this is a
#  valid spec and to remove all comments including this before submitting the spec.
#
#  To learn more about Podspec attributes see http://docs.cocoapods.org/specification.html
#  To see working Podspecs in the CocoaPods repo see https://github.com/CocoaPods/Specs/
#

Pod::Spec.new do |s|

  s.name         = "LLRocker"
  s.version      = "1.0.0"
  s.summary      = "use for Lilong LLRocker module."
  s.description  = <<-DESC
		   use for LLRocker module.
		   It’s awesome!!
                   DESC

  s.homepage     = "https://github.com/LiGuanWen/LLRocker"
  s.license      = "MIT"
  s.author       = { "Lilong" => "diqidaimu@qq.com" }
  s.platform     = :ios, "9.0"
  s.source       = { :git => "https://github.com/LiGuanWen/LLRocker.git", :branch => "#{s.version}" }
  s.source_files = "LLRockerClass/**/*.{h,m}"
  s.resources    = "LLRockerClass/**/*.xib","LLRockerClass/**/*.bundle","LLRockerClass/**/*.xcassets"
end
