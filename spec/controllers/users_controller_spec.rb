require 'spec_helper'

describe UsersController do

  describe "GET 'new'" do
    it "should be successful" do
      get 'new'
      response.should be_success
    end
  end
  
  describe "POST 'create'" do
    before(:each) do
      @attr = { :name => "jack jackson" ,
                 :email => 'test@test.test2' ,
                 :password => '1234567' ,
                 :password_confirmation => '1234567'
                 }
    end
    
    it "should create a user from valid info" do
      lambda do
        post :create, :user => @attr
      end.should change(User, :count).by(1)
    end
    
    it "should redirect after a valid creation" do
      post :create, :user => @attr
      flash[:success] =~ /welcome/i
    end
  end

  describe "GET 'index'" do
    it "should be successful" do
      get 'index'
      response.should be_success
    end
  end

end
