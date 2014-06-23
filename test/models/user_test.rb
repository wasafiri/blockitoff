require "test_helper"

# if you don't adjust your rakefile to run all tests, do
# ruby  -Ilib -I test  test/models/user_test.rb

describe "Creating User", :capybara do
#fixtures :users
  it "is successful in creating user via webpage" do
    visit new_user_registration_path
    fill_in "email", :with => users(:user1).email
    fill_in "password", :with => users(:user1).password
    click_button "Sign in"
    assert_redirected_to lists_path
    assert_equal 'A message with a confirmation link has been sent to your email address. Please open the link to activate your account.', flash[:notice]
  end

  it "is successful in creating a user via json" do
    #send json request
    #make sure correct json response is received
  end
end
