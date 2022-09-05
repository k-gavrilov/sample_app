require 'rails_helper'

RSpec.describe "Sessions", type: :request do
  let(:user) { create(:user) }

  describe "sessions" do
    it "should login with valid information" do
      get login_path
      post login_path, params: { session: { email: user.email,
                                            password: 'foobar' }}
      assert_redirected_to user
      follow_redirect!
      assert_template 'users/show'
      assert_select "a[href=?]", login_path, count: 0
      assert_select "a[href=?]", logout_path
      assert_select "a[href=?]", user_path(user)
    end
  end

  it "should not login with invalid password" do
    get login_path
    post login_path, params: { session: { email: user.email,
                                          password: 'incorrect' }}
    assert_template 'sessions/new'
    assert_not flash.empty?
    get root_path
    assert flash.empty?
  end

end
