require 'rails_helper'

describe ProfilesController, type: :controller do
  describe 'GET #show' do
    let(:profile) { create(:profile) }
    login_user
    before { get :show, params: { id: profile } }

    it 'assings the requested profile to @profile' do
      expect(assigns(:profile)).to eq(profile)
    end

    it 'renders show view' do
      expect(response).to render_template(:show)
    end
  end

  describe 'GET #edit' do
    let(:profile) { create(:profile) }
    login_user
    before { get :edit, params: { id: profile } }

    it 'assings the requested profile to @profile' do
      expect(assigns(:profile)).to eq(profile)
    end

    it 'render edit view' do
      expect(response).to render_template(:edit)
    end
  end

  describe 'PATCH #update' do
    context 'valid attributes' do
      let(:profile) { create(:profile) }
      login_user

      it 'assings the requested profile to @profile' do
        patch :update, params: { profile: attributes_for(:profile), id: profile }
        expect(assigns(:profile)).to eq(profile)
      end

      it 'changes profile attributes' do
        patch :update, params: { profile: { phone: 'new phone', first_name: 'new name' }, id: profile }
        profile.reload
        expect(profile.phone).to eq('new phone')
        expect(profile.first_name).to eq('new name')
      end

      it 'redirects to the show profile' do
        patch :update, params: { profile: attributes_for(:profile), id: profile }
        expect(response).to redirect_to assigns(:profile)
      end
    end

    context 'invalid attributes' do
    end
  end
end
