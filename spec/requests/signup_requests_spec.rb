require 'rails_helper'

RSpec.describe "SignupRequests", type: :request do
  it "shouldn't sign_up with invalid params" do
    get signup_path
    expect(response).to have_http_status(200)
    expect do
      post users_path, params: {
        user: {
          name: "",
          email: "user@invalid",
          password: "foo",
          password_confirmation: "bar"
        }
      }
    end.to_not change { User.count }
    assert_template 'users/new'
    assert_select 'div#error_explanation'
    assert_select 'div.alert-danger'
  end

  it "should sign up with valid params" do
    get signup_path
    expect(response).to have_http_status(200)
    expect do
      post users_path, params: {
        user: {
          name: "Ivan Petrovich",
          email: "ivan.p@test.com",
          password: "test_password",
          password_confirmation: "test_password"
        }
      }
    end.to change { User.count }.from(0).to(1)
    follow_redirect!
    assert_template 'users/show'
    expect(flash).not_to be_empty
  end
end
