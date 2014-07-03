require 'spec_helper'

describe Category do
  it { should have_many(:products) }
  it { should validate_presence_of(:name) }
  it { should validate_uniqueness_of(:name) }

  it "should return ransack attrs" do
    Category.ransackable_attributes.should eq %w(name)
  end
end