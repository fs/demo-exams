require File.dirname(__FILE__) + '/../test_helper'

class ClearanceTest < ActiveSupport::TestCase
  context "Signing" do
    setup do
      @user = Factory(:email_confirmed_user)
      sign_in_as @user
    end
    should_be_signed_in_as { @user }
  end
  
end