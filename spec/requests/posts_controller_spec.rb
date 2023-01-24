require 'rails_helper'

Rails.describe PostsController, type: :request do
  context 'Actions taken in user posts' do
    it 'Shoud make a successful request' do
      get user_posts_url(1)
      expect(response).to have_http_status(:ok)
    end

    it 'Shoud render the correct template' do
      get user_posts_url(1)
      expect(response).to render_template(:index)
    end

    it 'Shoud contain the correct response body' do
      get user_posts_url(1)
      expect(response.body).to include('<!DOCTYPE html>')
    end
  end

  context 'Actions on Detail view in a post for a given user' do
    it 'Should make a successful request' do
      get user_post_url(1, 1)
      expect(response).to have_http_status(:ok)
    end

    it 'Should render the correct template' do
      get user_post_url(1, 1)
      expect(response).to render_template(:show)
    end

    it 'Should contain the correct response body' do
      get user_post_url(1, 1)
      expect(response.body).to include('<!DOCTYPE html>')
    end
  end
end
