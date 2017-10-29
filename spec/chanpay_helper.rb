require 'spec_helper'

require 'support/const_support'
require 'support/quick_const_support'

RSpec.configure do |config|
  config.include ConstSupport
  config.include QuickConstSupport
end
