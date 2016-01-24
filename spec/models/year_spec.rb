require 'rails_helper'

RSpec.describe Year, type: :model do
  # Not passing in codeship: bundle exec rake
  # it { should have_valid(:year).when(1960, 1990)
  it { should_not have_valid(:year).when(nil, "", 1990.0) }
end
