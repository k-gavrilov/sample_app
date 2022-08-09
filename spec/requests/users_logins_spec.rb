require 'rails_helper'

RSpec.describe "UsersLogins", type: :request do
  it "login with invalid information" do
    get login_path
    assert_template 'sessions/new'
    post login_path, params: { session: { email: "", password: "" } }
    expect(flash).not_to be_empty
    get root_path
    expect(flash).to be_empty
  end
end
