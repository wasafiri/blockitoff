require "test_helper"

class CanAccessHomeTest < Capybara::Rails::TestCase
  test "sanity" do
    visit root_path
    assert_content page, "Your task lists"
  end

  test "should get index" do
    sign_in users(:one)
    get :index
    assert_response :success
    assert_select 'span#loggedin', :count => 1
  end
end
