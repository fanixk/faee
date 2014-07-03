require "spec_helper"

describe Admin::OrdersController do
  describe "routing" do

    it 'routes to #index' do
      get('/admin/orders').should route_to('admin/orders#index')
    end

    it "routes to #new" do
      get("/admin/orders/new").should route_to("admin/orders#new")
    end

    it "routes to #show" do
      get('/admin/orders/1').should route_to('admin/orders#show', id: '1')
    end
    
    it "routes to #edit" do
      get("/admin/orders/1/edit").should route_to("admin/orders#edit", id: '1')
    end

    it "routes to #create" do
      post("/admin/orders").should route_to("admin/orders#create")
    end

    it "routes to #update" do
      put("/admin/orders/1/").should route_to("admin/orders#update", id: '1')
    end

    it "routes to #destroy" do
      delete("/admin/orders/1").should route_to("admin/orders#destroy", id: '1')
    end

    it 'routes to #ship' do
      patch('/admin/orders/1/ship').should route_to('admin/orders#ship', order_id: '1')
    end

    it 'routes to #ship' do
      patch('/admin/orders/1/ship').should route_to('admin/orders#ship', order_id: '1')
    end
    it 'routes to #cancel' do
      patch('/admin/orders/1/cancel').should route_to('admin/orders#cancel', order_id: '1')
    end
    it 'routes to #resume' do
      patch('/admin/orders/1/resume').should route_to('admin/orders#resume', order_id: '1')
    end
    it 'routes to #complete' do
      patch('/admin/orders/1/complete').should route_to('admin/orders#complete', order_id: '1')
    end

    it 'routes to #index via search' do
      get('admin/orders/search').should route_to('admin/orders#index')
      post('admin/orders/search').should route_to('admin/orders#index')
    end
  end
end
