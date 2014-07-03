class Setting < ActiveRecord::Base
  attr_accessible :key, 
                  :value
                  
  validates :key,
            :presence   => true,
            :uniqueness => true

  after_commit :flush_cache

  KEYS = [
    :twitter_api_key, :twitter_api_secret, :fb_api_key, :fb_api_secret,
    :gateway_login, :gateway_password, :gateway_token,
    :billing_address_city, :billing_address_country,
    :store_title, :locale
  ].freeze

  self.instance_eval do
    def method_missing(method_name, *args, &block)
      KEYS.include?(method_name) ? run_find_setting_by_key(method_name) : super
    end

    def respond_to?(method_name, include_private = false)
      KEYS.include?(method_name) ? true : super
    end

    private 
      def run_find_setting_by_key(method_name)
        self.cached_find_by_key(method_name)
      end
  end

  def self.cached_find_by_key(key)
    Rails.cache.fetch([key]) { find_by_key(key).value }
  end

  def flush_cache
    Rails.cache.delete(self.key)
  end

end
