RSpec.configure do |config|
  config.before(:suite) do
    FileUtils.mkdir_p('test_result')
    FileUtils.mkdir_p('samples')
  end

  config.after(:suite) do
    FileUtils.rm_rf('test_result')
    FileUtils.rm_rf('samples')
  end
end
