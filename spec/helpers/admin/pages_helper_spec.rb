require 'spec_helper'

describe Admin::PagesHelper do
  describe "nested pages" do
    it "builds nested ul" do
      page1 = FactoryGirl.create(:page)
      page2 = FactoryGirl.create(:page, parent_id: page1.id)
      pages = Page.arrange
      helper.nested_pages(pages).should have_selector('li', count: 2+8) #plus 8 for 2 dropdown menus w/ 4 actions
      helper.nested_pages(pages).should have_selector("li#page_#{page1.id}")
      helper.nested_pages(pages).should have_selector("li#page_#{page2.id}")
      helper.nested_pages(pages).should have_selector("li", text: page1.name)
      helper.nested_pages(pages).should have_selector("li", text: page2.name)
      helper.nested_pages(pages).should have_selector('ul', count: 2+2) #plus 2 for two action menus
    end
  end

  describe "inner page div" do
    it 'builds div' do
      page = FactoryGirl.create(:page)
      helper.inner_page_div(page).should have_selector('div.pageDiv', text: page.name)
    end
  end

  describe 'page drag' do
    it 'builds cursor icon' do
      helper.page_drag.should have_selector('i.icon-move')
    end
  end
end
