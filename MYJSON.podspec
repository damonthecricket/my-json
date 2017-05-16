Pod::Spec.new do |spec|
  spec.name = "MYJSON"
  spec.version = "1.0.0"
  spec.summary = "Simple Swift JSON framework."
  spec.homepage = "https://github.com/damonthecricket/my-json"
  spec.license = { 
     type: 'MIT', file: 'LICENSE' 
  }
  spec.authors = { 
    "Damon Cricket" => 'damon.the.cricket@gmail.com' 
    }
  spec.social_media_url = "https://www.facebook.com/damonthecricketprograms/"

  spec.osx.deployment_target = "10.9"
  spec.ios.deployment_target = "8.0"
  spec.watchos.deployment_target = "2.0"
  spec.tvos.deployment_target = "9.0"

  spec.requires_arc = true
  spec.source = { git: "https://github.com/damonthecricket/my-json.git", tag: "v#{spec.version}", submodules: true }
  spec.source_files = "MYJSON/*.{h,swift}"
end
