require 'spec_helper'

describe Page do
  it "has a valid factory" do
    FactoryGirl.create(:page).should be_valid
  end

  describe "validations" do
    it "validates presence of name" do
      page = FactoryGirl.build(:page, name: '')
      page.should_not be_valid
    end

    it "validates uniqueness of name" do
      page1 = FactoryGirl.create(:page)
      page2 = FactoryGirl.build(:page, name: page1.name)
      page2.should_not be_valid
    end

    it "ensures exclusion of slug in certain words" do
      exclusions = ['users', 'user', 'admin', 'sign_up', 'sign_in', 'sign_out', 'store', 'en', 'gr']
      exclusions.each do |exclusion|
        page = FactoryGirl.build(:page, slug: exclusion)
        page.should_not be_valid
      end
    end

    it "validates slug for not containing slash or backslash" do
      page = FactoryGirl.build(:page, slug: 'test/test1')
      page.should_not be_valid
    end
  end

  it "inserts position automatically" do
    page1 = FactoryGirl.create(:page)
    page2 = FactoryGirl.create(:page)
    page1.position.should == 1
    page2.position.should == 2
  end

  it "creates slug same as name automatically" do
    page = FactoryGirl.create(:page)
    page.name.should == page.slug
  end
  
  it "keeps different slug if given" do
    page = FactoryGirl.create(:page, slug: 'test')
    page.name.should_not == page.slug
  end

  it "returns live state if is published and in menu" do
    page = FactoryGirl.create(:page)
    page.live?.should == true

    page2 = FactoryGirl.create(:page, is_published: false)
    page2.live?.should == false

    page3 = FactoryGirl.create(:page, in_menu: false)
    page3.live?.should == false
  end

  it "returns full slug as a string containing parent and page slug separated by slashes" do
    page1 = FactoryGirl.create(:page)
    page2 = FactoryGirl.create(:page, parent_id: page1.id)
    full_slug = page1.slug + '/' + page2.slug
    page2.full_slug.should == full_slug
  end

  it 'returns name with dashes for select' do
    page1 = FactoryGirl.create(:page)
    page2 = FactoryGirl.create(:page, parent_id: page1.id)
    page2.name_for_selects.should == "- #{page2.name}"
  end

  it 'arranges pages as an array' do
    page1 = FactoryGirl.create(:page)
    page2 = FactoryGirl.create(:page, parent_id: page1.id)
    Page.arrange_as_array.should be_kind_of Array
  end

end
