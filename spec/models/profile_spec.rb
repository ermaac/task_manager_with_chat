require 'rails_helper'

RSpec.describe Profile, type: :model do
  context 'profile testing' do
    describe 'validations' do
      before(:each) do
        @user = User.create email: 'test@example.com', password: '123123123', password_confirmation: '123123123'
        @profile = Profile.new
      end

      it { is_expected.to validate_presence_of :first_name }
      it { is_expected.to validate_presence_of :last_name }

      it 'requires user for creating profile' do
        @profile.update first_name: 'ivan', last_name: 'ivanov'
        expect(@profile.errors[:User]).to include('must exist')
      end

      it 'requires first_name for creating profile' do
        @profile.update last_name: 'ivanov'
        expect(@profile.errors[:first_name]).to include("can't be blank")
      end

      it 'requires last_name for creating profile' do
        @profile.update first_name: 'ivan'
        expect(@profile.errors[:last_name]).to include("can't be blank")
      end

      it 'is valid with valid attributes' do
        @profile.update first_name: 'ivan', last_name: 'ivanov', User_id: @user.id
        expect(@profile).to be_valid
      end

      it 'fails if first_name contains wrong symbols' do
        @profile.update first_name: 'iva.n', last_name: 'ivanov-smirnov', User_id: @user.id
        expect(@profile.errors[:first_name]).to include('allows only letters and dashes')
      end

      it 'fails if last_name contains wrong symbols' do
        @profile.update first_name: 'ivan', last_name: 'ivan0ov', User_id: @user.id
        expect(@profile.errors[:last_name]).to include('allows only letters and dashes')
      end

      it 'fails if birthdate has incorrect format' do
        @profile.update first_name: 'ivan', last_name: 'ivanov', birthdate: '1018.12.12', User_id: @user.id
        expect(@profile.errors[:birthdate]).to include('incorrect birthdate')
      end

      it 'creates profile if birthdate is given in correct format' do
        @profile.update first_name: 'ivan', last_name: 'ivanov', birthdate: '2014.12.12', User_id: @user.id
        expect(@profile).to be_valid
      end

      it 'creates profile if birthdate left blank' do
        @profile.update first_name: 'ivan', last_name: 'ivanov', User_id: @user.id
        expect(@profile).to be_valid
      end

      it 'fails if phone has incorrect format' do
        @profile.update first_name: 'ivan', last_name: 'ivanov', phone: '+1', User_id: @user.id
        expect(@profile.errors[:phone]).to include('incorrect phone')
      end

      it 'creates profile if phone is given in correct format' do
        @profile.update first_name: 'ivan', last_name: 'ivanov', phone: '+375291112233', User_id: @user.id
        expect(@profile).to be_valid
      end

      it 'creates profile if phone left blank' do
        @profile.update first_name: 'ivan', last_name: 'ivanov', User_id: @user.id
        expect(@profile).to be_valid

      end
    end

    describe 'relations' do
      it { is_expected.to belong_to :User }
    end
  end
end
