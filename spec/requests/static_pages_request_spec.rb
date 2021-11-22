require 'rails_helper'

RSpec.describe "StaticPages", type: :request do
let(:base_title) { "Ruby on Rails Tutorial Sample App" }

  it 'should get root' do
    get root_path
    expect(response).to have_http_status(200)
    assert_select "title", base_title
  end

  it "should get help" do
    get help_path
    expect(response).to have_http_status(200)
    assert_select "title", "Help | #{base_title}"
  end

  it "should get about" do
    get about_path
    expect(response).to have_http_status(200)
    assert_select "title", "About | #{base_title}"
  end

  it "should get contact" do
    get contact_path
    expect(response).to have_http_status(200)
    assert_select "title", "Contact | #{base_title}"
  end
end
