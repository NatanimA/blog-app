require 'rails_helper'

Rails.describe LikesController, type: :request do
  context 'Action new like' do
    it 'Shoud make successful request' do
      get new_post_like_path(post_id: 1)
      expect(response).to have_http_status(:ok)
    end

    it 'Should render the correct template' do
      get new_post_like_path(post_id: 1)
      expect(response).to render_template(:new)
    end

    it 'Shoud return the correct response body' do
      get new_post_like_path(post_id: 1)
      expect(response.body).to include('<!DOCTYPE html>')
    end
  end

  context 'Action on creating a new like' do
    before :all do
      @like = Like.new(author_id: 1, post_id: 1)
    end
    it 'Should make successful request' do
      post post_likes_path(post_id: 1), params: { author_id: 1, post_id: 1 }
      expect(response).to have_http_status(:found)
    end

    it 'Should contain the correct response body' do
      post post_likes_path(post_id: 1), params: { author_id: 1, post_id: 1 }
      expect(response.content_type).to eq 'text/html; charset=utf-8'
    end
  end
end
