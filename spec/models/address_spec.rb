require 'spec_helper'

describe Address do
  it "has a valid factory" do 
    FactoryGirl.create(:address).should be_valid
  end 

  it { should belong_to(:user) }
  it { should have_many(:orders) }

  it { should validate_uniqueness_of(:label).scoped_to(:user_id) }
  it { should validate_presence_of(:user_id) }
  it { should validate_presence_of(:label) }
  it { should validate_presence_of(:street_name) }
  it { should validate_presence_of(:street_num) }
  it { should validate_presence_of(:region) }
  it { should validate_presence_of(:zipcode) }
  it { should validate_presence_of(:phone) }
  it { should validate_numericality_of(:phone) }
  
  before do
    @address = FactoryGirl.create(:address)
  end

  it "returns full address as a string" do
    address = FactoryGirl.create(:address, street_name: "Panepistimiou", street_num: 1)
    address.full_address.should == "Panepistimiou 1"
  end

  it "returns geo address as a comma delimited string" do
    address = FactoryGirl.create(:address, street_name: "Panepistimiou", street_num: 1, region: 'Kentro', zipcode: '11111' )
    address.geo_address.should == 'Panepistimiou 1, Kentro, 11111'
  end

  it "return true if geo_address has changed" do
    address = FactoryGirl.create(:address)
    address.street_name = 'Panepistimiou'
    address.geo_address_changed?.should be_true
  end

  it "return false if geo_address has changed" do
    address = FactoryGirl.create(:address)
    address.geo_address_changed?.should be_false
  end

end
