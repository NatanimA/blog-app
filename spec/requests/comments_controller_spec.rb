require 'rails_helper'

Rails.describe CommentsController, :type => :request do
  context "Action on displaying form for comments" do
    it "Should make successful request" do
      get new_comment_path
      expect(response).to have_http_status(:ok)
    end

    it "Should render the correct template" do
      get new_comment_path
      expect(response).to render_template(:new)
    end

    it "Should match the response body" do
      get new_comment_path
      expect(response.body).to include("<!DOCTYPE html>")
    end
  end

  context "Action given creating new comment" do
    before :all do
      @comment = Comment.new(text: 'Hello there!', post_id: 1, author_id: 1)
    end
    it "Should make a successful request" do
      post comments_path(@comment)
      expect(response).to have_http_status(:ok)
    end

    it "Should match the reponse body" do
      post comments_path(@comment)
      expect(response.body).to include("<!DOCTYPE html>")
    end
  end

end
