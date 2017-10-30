require "bundler/gem_tasks"
require "rspec/core/rake_task"

RSpec::Core::RakeTask.new(:spec)

task :default => :spec

task :build do
  puts `gem build chan_pay.gemspec`
end

task :push do
  puts `gem push chan_pay-#{ChanPay::VERSION}.gem`
end

task :publish => [:build, :push]
