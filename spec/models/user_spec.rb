require 'rails_helper'

RSpec.describe User, type: :model do


  it 'is valid with valid attributes' do
    expect(build(:user)).to be_valid
  end

  it 'is not valid with empty email' do
    expect(build(:user, email: "")).to_not be_valid
  end

  it "is not valid with too long name" do
    expect(build(:user, name: "a" * 51)).to_not be_valid
  end

  it "is not valid with too long email" do
    expect(build(:user, email: "a" * 244 + "@example.com")).to_not be_valid
  end

  it "is valid with valid emails" do
    addresses = %w[USER@foo.COM THE_US-ER@foo.bar.org first.last@foo.jp]
    addresses.each do |address|
      expect(build(:user, email: address)).to be_valid("#{address} should be valid")
    end
  end

  it "is not valid with invalid emails" do
    addresses = %w[user@example,com user_at_foo.org user.name@example.
foo@bar_baz.com foo@bar+baz.com foo@bar..com]
    addresses.each do |address|
      expect(build(:user, email: address)).to_not be_valid("#{address} should be valid")
    end
  end

  it "is not valid with duplicated email" do
    create(:user, email: "foo@bar.com")
    expect(build(:user, email: "foo@bar.com")).to be_invalid
  end

  it "saves to DB lowercased versions of emails" do
    mixed_case_email = "Foo@Bar.com"
    u = create(:user, email: mixed_case_email)
    expect(u.reload.email).to eq(mixed_case_email.downcase)
  end

  it "is not valid with blank password" do
    blank_password = " " * 10
    user = build(:user, password: blank_password, password_confirmation: blank_password)
    expect(user).to be_invalid
  end

  it "should require minimum password length" do
    short_password = "a" * 5
    user = build(:user, password: short_password, password_confirmation: short_password)
    expect(user).to be_invalid
  end

  it 'should return false on calling authenticated? on a user without digest' do
    expect(build(:user).authenticated?('')).to be_falsey
  end
end
