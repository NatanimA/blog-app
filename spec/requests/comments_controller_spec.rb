require 'rails_helper'

Rails.describe CommentsController, type: :request do
  context 'Action on displaying form for comments' do
    it 'Should make successful request' do
      get new_post_comment_path(1)
      expect(response).to have_http_status(:ok)
    end

    it 'Should render the correct template' do
      get new_post_comment_path(1)
      expect(response).to render_template(:new)
    end

    it 'Should match the response body' do
      get new_post_comment_path(1)
      expect(response.body).to include('<!DOCTYPE html>')
    end
  end

  context 'Action given creating new comment' do
    before :all do
      @comment = Comment.new(text: 'Hello there!', post_id: 1, author_id: 1)
    end
    it 'Should make a successful request' do
      post post_comments_path(:post_id => 2), :params => {:new_comment => {:text => 'Hello there!', :post_id => 1, :author_id => 1}}
      expect(response).to have_http_status(:found)
    end

    it 'Should match the reponse body' do
      post post_comments_path(:post_id => 1), :params => {:new_comment => {:text => 'Hello there!', :post_id => 1, :author_id => 1}}
       expect(response.content_type).to eq "text/html; charset=utf-8"
    end
  end
end
