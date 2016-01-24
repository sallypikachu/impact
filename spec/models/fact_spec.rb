require 'rails_helper'

RSpec.describe Fact, type: :model do
  it { should have_valid(:data).when(1960, 1990) }
  it { should_not have_valid(:data).when(nil, "") }
end
