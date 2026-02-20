require "minitest/test_task"
require_relative "./test/TestCheckMove.rb"

Minitest::TestTask.create(:test) do |t|
  t.libs << "test"
  t.libs << "lib"
  t.warning = false
  t.test_globs = ["test/*.rb"]
end

task :default => :test
