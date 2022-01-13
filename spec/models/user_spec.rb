require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'Validations' do
    
    it 'should NOT save a new user to DB while password fields do not match' do
      user = User.create(
        name: "test",
        
        email: "testspec@test.com",
        password: "testspec123",
        password_confirmation: "testspec"
      )

      expect(user).to_not be_valid
    end

    it 'should save a new user to DB when all fields are valid' do
      user = User.create(
        name: "test",
        
        email: "testspec@test.com",
        password: "testspec123",
        password_confirmation: "testspec123"
      )

      expect(user).to be_valid
    end

    it 'should not save a new user to DB when email is NOT unique' do
      user1 = User.create(
        name: "test",
        
        email: "testspec@test.com",
        password: "testspec123",
        password_confirmation: "testspec123"
      )
      user2 = User.create(
        name: "testy",
        
        email: "testSpec@test.com",
        password: "testspec1234",
        password_confirmation: "testspec1234"
      )

      expect(user2).to_not be_valid
    end

    it 'should not save a new user to DB when password is less than 6 characters' do
      user = User.create(
        name: "test",
        
        email: "testspec@test.com",
        password: "spec",
        password_confirmation: "spec"
      )

      expect(user).to_not be_valid
    end
    it 'should save a new user to DB when password is 6 or more characters' do
      user = User.create(
        name: "test",
        
        email: "testspec@test.com",
        password: "spec12",
        password_confirmation: "spec12"
      )

      expect(user).to be_valid
    end
  end

  describe '.authenticate_with_credentials' do

    before do
      @user = User.create(
        name: "Hello",
       
        email: "HelloWorld@test.com",
        password: "spec123",
        password_confirmation: "spec123"
      )
    end

    it 'should login a user with valid authentication' do
      user = User.authenticate_with_credentials("HelloWorld@test.com", "spec123")

      expect(user).to eq(@user)
    end

    it 'should NOT login a user with invalid authentication' do
      user = User.authenticate_with_credentials("HelloWorld@test.com", "spec1234")

      expect(user).to be nil
    end

    it 'should login a user while ignoring whitespace with valid authentication' do
      user = User.authenticate_with_credentials("   HelloWorld@test.com   ", "spec123")

      expect(user).to eq(@user)
    end

    it 'should login a user while ignoring text casing with valid authentication' do
      user = User.authenticate_with_credentials("HELLOWORLD@test.com", "spec123")

      expect(user).to eq(@user)
    end

  end
end