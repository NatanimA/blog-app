require 'rails_helper'

Rails.describe UsersController, type: :request do
  describe '#Making a request' do
    context "Actions on 'index'" do
      it 'Should make a request to index' do
        get root_path
        expect(response).to have_http_status(:ok)
      end
      it 'Should render the correct template' do
        get root_path
        expect(response).to render_template(:index)
      end
      it 'Should return the correct response body' do
        get root_path
        expect(response.body).to include('<!DOCTYPE html>')
      end
    end
    context "Actions on users 'show" do
      it 'Should make a request to :show' do
        get user_path(1)
        expect(response).to have_http_status(:ok)
      end
      it 'Should render the correct template' do
        get user_path(1)
        expect(response).to render_template(:show)
      end
      it 'Should return the correct response body' do
        get user_path(1)
        expect(response.body).to include('<!DOCTYPE html>')
      end
    end

    context "Actions on users 'edit" do
      it 'Should make a request to :show' do
        get edit_user_path(1)
        expect(response).to have_http_status(:ok)
      end
      it 'Should render the correct template' do
        get edit_user_path(1)
        expect(response).to render_template(:edit)
      end
      it 'Should return the correct response body' do
        get edit_user_path(1)
        expect(response.body).to include('')
      end
    end
  end
end
