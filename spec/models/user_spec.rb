require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'Validations' do

    it "should save if all fields are set" do
      user = User.new(first_name: "Bob", last_name: "Bobertson", email: "bobbob.com", password: "12345678", password_confirmation: "12345678")
      user.save!
      expect(user).to be_valid
    end
    
    it "should throw an error if first name is empty" do
      user = User.new(first_name: nil, last_name: "Bobertson", email: "bobbob.com", password: "12345678", password_confirmation: "12345678")
      user.save
      expect(user.errors.full_messages).to include("First name can't be blank")
    end

    it "should throw an error if last name is empty" do
      user = User.new(first_name: "Bob", last_name: nil, email: "bobbob.com", password: "12345678", password_confirmation: "12345678")
      user.save
      expect(user.errors.full_messages).to include("Last name can't be blank")
    end

    it "should throw an error if email is empty" do
      user = User.new(first_name: "Bob", last_name: "Bobertson", email: nil, password: "12345678", password_confirmation: "12345678")
      user.save
      expect(user.errors.full_messages).to include("Email can't be blank")
    end
    
    it "should throw an error if password is empty" do
      user = User.new(first_name: "Bob", last_name: "Bobertson", email: "bobbob.com", password: nil, password_confirmation: "12345678")
      user.save
      expect(user.errors.full_messages).to include("Password can't be blank")
    end

    it "should throw an error if password confirmtion is empty" do
      user = User.new(first_name: "Bob", last_name: "Bobertson", email: "bobbob.com", password: "12345678", password_confirmation: nil)
      user.save
      expect(user.errors.full_messages).to include("Password confirmation can't be blank")
    end

    it "should throw an error if passwords do not match" do
      user = User.new(first_name: "Bob", last_name: "Bobertson", email: "bobbob.com", password: "12345678", password_confirmation: "87654321")
      user.save
      expect(user.errors.full_messages).to include("Password confirmation doesn't match Password")
    end

    it "should throw an error if email is not unique" do
      user1 = User.new(first_name: "Bob", last_name: "Bobertson", email: "bobbob.com", password: "12345678", password_confirmation: "12345678")
      user1.save
      user2 = User.new(first_name: "Bob", last_name: "Bobertson", email: "bobbob.com", password: "24681357", password_confirmation: "24681357")
      user2.save
      expect(user2.errors.full_messages).to include("Email has already been taken")
    end

    it "should throw an error if password is too short" do
      user = User.new(first_name: "Bob", last_name: "Bobertson", email: "bobbob.com", password: "123456", password_confirmation: "123456")
      user.save
      expect(user.errors.full_messages).to include("Password is too short (minimum is 8 characters)")
    end
  end


  describe '.authenticate_with_credentials' do
    
    before do
      @user = User.new(first_name: "Bob", last_name: "Bobertson", email: "bob@bob.com", password: "12345678", password_confirmation: "12345678")
      @user.save
    end
    
    it "should authenticate user if valid credentials" do
      expect(User.authenticate_with_credentials(@user.email, @user.password)).not_to be_nil
    end

    it "should throw an error if email is wrong" do
      expect(User.authenticate_with_credentials("bob@bo.com", @user.password)).to be_nil
    end
   
    it "should throw an error if password is wrong" do
      expect(User.authenticate_with_credentials(@user.email, '87654321')).to be_nil
    end

    it "should validate email with spaces before or after" do
      expect(User.authenticate_with_credentials("   bob@bob.com   ", @user.password)).to_not be_nil
    end

    it "should validate email with either cases" do
      expect(User.authenticate_with_credentials("bOB@Bob.CoM", @user.password)).to_not be_nil
    end
  end
end
