require 'rails_helper'
require './spec/support/session_helpers'

RSpec.configure do |c|
  c.include SessionHelpers
end

RSpec.describe "Sessions", type: :request do
  let(:user) { create(:user) }

  describe "sessions" do
    it "should login with valid information followed by logout" do
      get login_path
      post login_path, params: { session: { email: user.email,
                                            password: 'foobar' }}
      assert_redirected_to user
      follow_redirect!
      assert_template 'users/show'
      assert_select "a[href=?]", login_path, count: 0
      assert_select "a[href=?]", logout_path
      assert_select "a[href=?]", user_path(user)
      delete logout_path
      expect(is_logged_in?).not_to be_truthy
      expect(response).to redirect_to(root_url)
      follow_redirect!
      assert_select "a[href=?]", login_path
      assert_select "a[href=?]", logout_path, count: 0
      assert_select "a[href=?]", user_path(user), count: 0
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
