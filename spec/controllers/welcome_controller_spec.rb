require 'spec_helper'

describe WelcomeController do

  describe "GET 'homepage'" do
    it "returns http success" do
      get 'homepage'
      response.should be_success
    end
  end

end
