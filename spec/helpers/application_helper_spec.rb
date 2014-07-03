require 'spec_helper'

describe ApplicationHelper do
  describe "hidden div if" do
    it "has style hidden if condition" do
      helper.hidden_div_if(true).should == "<div>{&quot;style&quot;=&gt;&quot;display: none&quot;}</div>"
    end

    it "hasnt style attr if not condition" do
      helper.hidden_div_if(false).should == "<div>{}</div>"
    end
  end

  describe 'split path' do
    it 'returns home if path is /' do
      helper.request.stub(:path) { '/' }
      helper.split_path.should eq 'home'
    end

    it 'returns path splitted by / and separated with space' do
      helper.request.stub(:path) { '/test/test1' }
      helper.split_path.should eq 'test test1'
    end
  end

  describe 'full title' do
    context 'with page title' do
      it 'returns base title | page title' do
        setting = FactoryGirl.create(:setting, key: 'store_title')
        setting.run_callbacks(:commit)
        helper.full_title('test').should == "#{setting.value} | test"
      end
    end

     context 'with no page title' do
      it 'returns base title' do
        setting = FactoryGirl.create(:setting, key: 'store_title')
        setting.run_callbacks(:commit)
        helper.full_title('').should == "#{setting.value}"
      end
    end
  end
end
