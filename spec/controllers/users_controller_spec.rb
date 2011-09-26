require 'spec_helper'

describe UsersController do

  describe "POST 'create'" do
    before(:each) do
      @attr = { :name => 'name name' ,
      :email => 'em@il.com',
      :password => '1234567' ,
      :password_confirmation => '1234567',
      }
    end
    
    it "should make a user" do
      post :create, :user => @attr
      flash[:notice] =~ /created/i
    end
    
    it "should change up stuff" do
      lambda do
        post :create, :user => @attr
      end.should change(User, :count).by(1)
    end
  end

end
