desc 'Build and run all the specs...'
task :test do
  sh "xctool -workspace TMDBKit.xcworkspace -scheme TMDBKitTests test -sdk iphonesimulator"
end

desc 'Run all the specs...'
task :spec do
  sh "xctool -workspace TMDBKit.xcworkspace -scheme TMDBKitTests run-tests -sdk iphonesimulator"
end

desc 'Build...'
task :build do
  sh "xctool -workspace TMDBKit.xcworkspace -scheme TMDBKitTests build-tests -sdk iphonesimulator"
end

task :default => :test
