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
    end.to_not change{ User.count }
    assert_template 'users/new'
    assert_select 'div#error_explanation'
    assert_select 'div.alert-danger'
  end
end
