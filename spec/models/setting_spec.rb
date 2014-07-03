require 'spec_helper'

describe Setting do
  it { should validate_presence_of(:key) }
  it { should validate_uniqueness_of(:key) }

  it "does not respond to key not included in settings list" do
    setting = Setting.create(key: 'key1', value: 'value1' )
    Setting.should_not respond_to(:key1)
  end

  it "responds to keys included in settings list" do
    setting = Setting.create(key: 'twitter_api_key', value: 'value1' )
    Setting.should respond_to(:twitter_api_key)
  end

  it "finds value of setting by key" do
    setting = Setting.create(key: 'twitter_api_key', value: 'value1' )
    Setting.twitter_api_key.should == 'value1'
  end

  it 'flushes cache after commit' do
    setting = Setting.create(key: 'twitter_api_key', value: 'value1' )
    setting_value = Setting.twitter_api_key
    setting.update_attributes({value: 'test'} )
    setting.run_callbacks(:commit) #fire after commit callback manually since rspec doesnt fire it
    Rails.cache.exist?(setting.key).should be_false
  end
end
