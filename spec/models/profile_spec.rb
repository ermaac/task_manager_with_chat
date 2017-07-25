require 'rails_helper'

RSpec.describe Profile, type: :model do
  describe 'validations' do
    before(:each) do
      @user = build(:user)
      @profile = build(:profile)
      @profile.user = @user
    end

    it { is_expected.to validate_presence_of :first_name }
    it { is_expected.to validate_presence_of :last_name }

    it 'requires user for creating profile' do
      @profile.user = nil
      @profile.valid?
      expect(@profile.errors[:user]).to include('must exist')
    end

    it 'requires first_name for creating profile' do
      @profile.first_name = nil
      @profile.valid?
      expect(@profile.errors[:first_name]).to include("can't be blank")
    end

    it 'requires last_name for creating profile' do
      @profile.last_name = nil
      @profile.valid?
      expect(@profile.errors[:last_name]).to include("can't be blank")
    end

    it 'is valid with valid attributes' do
      expect(@profile).to be_valid
    end

    it 'fails if first_name contains wrong symbols' do
      @profile.first_name = 'iva.n'
      @profile.valid?
      expect(@profile.errors[:first_name]).to include('allows only letters and dashes')
    end

    it 'fails if last_name contains wrong symbols' do
      @profile.last_name = 'ivan0v'
      @profile.valid?
      expect(@profile.errors[:last_name]).to include('allows only letters and dashes')
    end

    it 'fails if birthdate has incorrect format' do
      @profile.birthdate = '1010.12.12'
      @profile.valid?
      expect(@profile.errors[:birthdate]).to include('incorrect birthdate')
    end

    it 'creates profile if birthdate left blank' do
      @profile.birthdate = nil
      @profile.valid?
      expect(@profile).to be_valid
    end

    it 'fails if phone has incorrect format' do
      @profile.phone = '+1'
      @profile.valid?
      expect(@profile.errors[:phone]).to include('incorrect phone')
    end

    it 'creates profile if phone left blank' do
      @profile.phone = nil
      @profile.valid?
      expect(@profile).to be_valid
    end

    it 'deletes profile when user is deleted' do
      @profile.save
      @user.destroy
      expect(Profile.exists?(@profile.id)).to be_falsy
    end
  end

  describe 'relations' do
    it { is_expected.to belong_to :user }
  end
end
