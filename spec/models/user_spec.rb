require 'spec_helper'

describe User do
  it { should have_many(:addresses) }
  it { should have_many(:orders) }

  it { should validate_presence_of(:username) }
  it { should validate_presence_of(:first_name) }
  it { should validate_presence_of(:last_name) }
  it { should validate_presence_of(:email) }
  it { should validate_presence_of(:password) }
  it { should validate_uniqueness_of(:username) }
  it { should validate_uniqueness_of(:email) }

  it { should_not allow_value("blah").for(:email) }
  it { should allow_value("a@b.com").for(:email) }

  it { should_not allow_mass_assignment_of(:admin) }


  before do
    @user = FactoryGirl.create(:user)
  end

  it "should have valid factory" do
    @user.should be_valid
  end

  it "should return full name as string" do
    user = FactoryGirl.create(:user, first_name: 'Mpampis', last_name: 'Sougias')
    user.full_name.should == 'Mpampis Sougias'
  end

  it "should count total customers" do
    admin = FactoryGirl.create(:user, admin: true)
    User.total_customers.should == 1
  end

  it "should require password for normal users" do
    @user.password_required?.should be_true
  end

  it "should not require password if user has logged in from omniauth" do
    user = FactoryGirl.create(:user, provider: 'twitter')
    user.password_required?.should be_false
  end

  it "should count total user orders" do
    order1 = FactoryGirl.create(:order, user_id: @user.id)
    order2 = FactoryGirl.create(:order, user_id: @user.id)

    @user.total_orders.should == 2
  end

  it "returns total spent" do
    order1 = FactoryGirl.create(:order, user_id: @user.id)
    order2 = FactoryGirl.create(:order, user_id: @user.id)
    @user.total_spent.should eq order1.price + order2.price
  end

  it "returns complete user orders" do
    order1 = FactoryGirl.create(:order, user_id: @user.id, state: 'complete')
    order2 = FactoryGirl.create(:order, user_id: @user.id, state: 'complete')
    @user.complete_orders.should eq [order2,order1]
  end

  it "should return ransack attrs" do
    User.ransackable_attributes.should eq %w(first_name last_name username email)
  end

  describe "#update_with_password" do
  context "when encrypted password is blank" do

    before(:each) do
      @user_fb = FactoryGirl.build(:user, :via_facebook)
      @user_fb.save(validate: false)
    end

    it "updates user attributes without asking current password" do
      @user_fb.update_with_password({first_name: "New First Name"})
      @user_fb.first_name.should eql "New First Name"
    end

  end
end
end
