require 'rails_helper'
require 'requests/shared/session_test_helper'

RSpec.configure do |c|
  c.include SessionTestHelper
end

RSpec.describe "UsersLogins", type: :request do
  let(:user) { create(:user, password: 'password', password_confirmation: 'password') }

  it "login with invalid information" do
    get login_path
    assert_template 'sessions/new'
    post login_path, params: { session: { email: "", password: "" } }
    expect(flash).not_to be_empty
    get root_path
    expect(flash).to be_empty
  end

  it 'should remember user when remember_me is set' do
    log_in_as(user, remember_me: 1)
    expect(cookies[:remember_token]).not_to be_nil
  end

  it 'should forget remember token upon signing in without remember_me'do
    log_in_as(user, remember_me: 1)
    log_in_as(user, remember_me: 0)
    expect(cookies[:remember_token].blank?).to be_truthy
  end
end
