require 'rails_helper'

Rails.describe LikesController, type: :request do
  context 'Action new like' do
    it 'Shoud make successful request' do
      get new_like_path
      expect(response).to have_http_status(:ok)
    end

    it 'Should render the correct template' do
      get new_like_path
      expect(response).to render_template(:new)
    end

    it 'Shoud return the correct response body' do
      get new_like_path
      expect(response.body).to include('<!DOCTYPE html>')
    end
  end

  context 'Action on creating a new like' do
    before :all do
      @like = Like.new(author_id: 1, post_id: 1)
    end
    it 'Should make successful request' do
      post likes_path(@like)
      expect(response).to have_http_status(:ok)
    end

    it 'should render the correct template' do
      post likes_path(@like)
      expect(response).to render_template(:new)
    end

    it 'Should contain the correct response body' do
      post likes_path(@like)
      expect(response.body).to include('<!DOCTYPE html>')
    end
  end
end
