require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'Validation' do
    # validate password fields
    it "is valid with matching password and password_confirmation" do
      @user = User.new(
        first_name: "Test",
        last_name: "User",
        email: "email@email.com",
        password: "password",
        password_confirmation: "password")

      @user.save
      expect(@user).to be_valid
    end

    it "is not valid with matching password and password_confirmation" do
      @user = User.new(
        first_name: "Test",
        last_name: "User",
        email: "email@email.com",
        password: "password",
        password_confirmation: "Password")

      @user.save
      expect(@user).to_not be_valid
    end

    # validate unique email
    it "is not valid with an existing email" do
      @user = User.new(
        first_name: "Test",
        last_name: "User",
        email: "email@email.com",
        password: "password",
        password_confirmation: "password")

      @user2 = User.new(
        first_name: "Test2",
        last_name: "User2",
        email: "email@email.com",
        password: "password",
        password_confirmation: "password")

      @user.save
      @user2.save
      expect(@user2).to_not be_valid
    end

    # require email, first name, last name
    it "is not valid without email" do
      @user = User.new(
        first_name: "Test",
        last_name: "User",
        email: nil,
        password: "password",
        password_confirmation: "password")

      @user.save
      expect(@user).to_not be_valid
    end

    it "is not valid without first_name" do
      @user = User.new(
        first_name: nil,
        last_name: "User",
        email: "email@email.com",
        password: "password",
        password_confirmation: "password")

      @user.save
      expect(@user).to_not be_valid
    end

    it "is not valid without last_name" do
      @user = User.new(
        first_name: "Test",
        last_name: nil,
        email: "email@email.com",
        password: "password",
        password_confirmation: "password")

      @user.save
      expect(@user).to_not be_valid
    end
  end

  # password minimum length
  describe "Password" do
    it "is not valid with less than 6 characters" do
      @user = User.new(
        first_name: "Test",
        last_name: "User",
        email: "email@email.com",
        password: "poo",
        password_confirmation: "poo")

      @user.save
      expect(@user).to_not be_valid
    end
  end

  # authenticate with credentials
  describe ".authenticate_with_credentials" do
    it "should be authenticated" do
      @user = User.new(
        first_name: "Test",
        last_name: "User",
        email: "email@email.com",
        password: "password",
        password_confirmation: "password")

      @user.save
      user = User.authenticate_with_credentials("email@email.com", "password")
      expect(user).to_not be nil
    end
  end
end
