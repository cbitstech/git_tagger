require "simplecov"
SimpleCov.start

# eagerly load Ruby files for accurate coverage
Dir[File.expand_path("../../app/**/*.rb", __FILE__)].each do |file|
  require file
end
Dir[File.expand_path("../../lib/**/*.rb", __FILE__)].each do |file|
  require file
end
