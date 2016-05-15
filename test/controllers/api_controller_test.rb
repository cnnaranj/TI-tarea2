require 'test_helper'

class ApiControllerTest < ActionController::TestCase
  # test "the truth" do
  #   assert true
  # end

  test "should not create instagram class without access_token" do
  	@instagram= Instagram.new()
  	assert_not @instagram.auth.nil?	
  end
  
  test "should respond with 200" do
  	params= {'access_token' => "2019746130.59a3f2b.86a0135240404ed5b908a14c0a2d9402", 'tag' => "snow" }
  	:search
  	assert_response(:success, message = nil)
  end
end
