require 'rails_helper'

Rails.describe 'Blog App', type: :system do
  before :each do
    img = 'https://i.pinimg.com/originals/08/8f/0a/088f0a8462a65c1efaecac2d74707690.png'
    @user = User.create(name: 'Natanim', photo: img, bio: 'Full-stack developer', posts_counter: 1)
    @post1 = Post.create(title: 'How I became self taught programmer.',
                         text: 'This is how I became the most amazing developer in history',
                         comments_counter: 0,
                         likes_counter: 0,
                         author_id: @user.id)
    @post2 = Post.create(title: 'The amazing run',
                         text: 'The day I started Coding',
                         comments_counter: 0,
                         likes_counter: 0,
                         author_id: @user.id)

    @post3 = Post.create(title: 'The reason I joined Microverse',
                         text: 'My Microverse Journey was',
                         comments_counter: 0,
                         likes_counter: 0,
                         author_id: @user.id)

    @comment = Comment.create(text: 'Hello there!', post_id: @post1.id, author_id: 1)
  end
  context '#User Index Interaction' do
    it 'Should visit root path' do
      visit root_path
      expect(page).to have_content(@user.name)
    end

    it 'Should see the username of other users' do
      visit root_path
      expect(page).to have_selector('.user-name')
    end

    it 'Should see the profile pictures of the other users' do
      visit root_path
      expect(page).to have_css("img[src*='#{@user.photo}']")
    end

    it 'Should redirect to user details' do
      visit root_path
      expect(page).to have_css('.user-link-container')
      page.all('.user-link-container').each do |user|
        visit user[:href]
        expect(response).to be nil
      end
    end
  end

  context '#User Page Interaction' do
    it 'Should have a profile picture' do
      visit user_path(@user.id)
      expect(page).to have_css("img[src*='#{@user.photo}']")
    end

    it 'Should see the username' do
      visit user_path(@user.id)
      expect(page).to have_css('.user-name')
      expect(page).to have_content(@user.name)
    end

    it 'Should Display the numper of posts for the user' do
      visit user_path(@user.id)
      expect(page).to have_css('.num-posts', text: "Number of posts: #{@user.posts_counter}")
    end

    it 'Should Display the Bio of the user' do
      visit user_path(@user.id)
      expect(page).to have_css('.user-bio-content', text: @user.bio.to_s)
    end

    it 'Should display the first 3 recent posts' do
      visit user_path(@user.id)
      expect(page).to have_css('.posts-content', text: @post1.text.to_s)
      expect(page).to have_css('.posts-content', text: @post2.text.to_s)
      expect(page).to have_css('.posts-content', text: @post3.text.to_s)
    end

    it 'Should have a button that says all posts' do
      visit user_path(@user.id)
      expect(page).to have_button('See all Posts')
    end

    it 'Should redirect users to all posts page when button is clicked' do
      visit user_path(@user.id)
      click_link('See all Posts')
      expect(page).to have_current_path("/users/#{@user.id}/posts")
    end

    it 'Should redirect back to users to index page when button is clicked' do
      visit user_posts_path(@user.id)
      click_link('Pagination')
      expect(page).to have_current_path("/users/#{@user.id}")
    end
  end

  context '#User post index page:' do
    it "Should I can see the user's profile picture." do
      visit user_posts_path(@user.id)
      expect(page).to have_css("img[src*='#{@user.photo}']")
    end

    it "Should see the user's username." do
      visit user_posts_path(@user.id)
      expect(page).to have_css('.user-name', text: @user.name.to_s)
    end

    it 'Should see the number of posts the user has written.' do
      visit user_posts_path(@user.id)
      expect(page).to have_css('.num-posts', text: @user.posts_counter.to_s)
    end

    it "Should see a post's title." do
      visit user_posts_path(@user.id)
      expect(page).to have_css('.post-title-header', text: @post1.title.to_s)
      expect(page).to have_css('.post-title-header', text: @post2.title.to_s)
      expect(page).to have_css('.post-title-header', text: @post3.title.to_s)
    end

    it "Should see some of the post's body" do
      visit user_posts_path(@user.id)
      expect(page).to have_css('.posts-content', text: @post1.text.to_s)
      expect(page).to have_css('.posts-content', text: @post2.text.to_s)
      expect(page).to have_css('.posts-content', text: @post3.text.to_s)
    end

    it 'Should see the first comments on a post' do
      visit user_posts_path(@user.id)
      expect(page).to have_css('.comments-content', text: @comment.text.to_s)
    end

    it 'Should see how many comments a post has.' do
      visit user_posts_path(@user.id)
      expect(page).to have_css('.counter-btn', text: "Add Comment: #{@post1.comments_counter}")
      expect(page).to have_css('.counter-btn', text: "Add Comment: #{@post2.comments_counter}")
      expect(page).to have_css('.counter-btn', text: "Add Comment: #{@post3.comments_counter}")
    end

    it 'Should see how many likes a post has.' do
      visit user_posts_path(@user.id)
      expect(page).to have_css('.counter-like-btn', text: "Likes: #{@post1.likes_counter}")
      expect(page).to have_css('.counter-like-btn', text: "Likes: #{@post2.likes_counter}")
      expect(page).to have_css('.counter-like-btn', text: "Likes: #{@post3.likes_counter}")
    end

    it 'Should see a section for pagination if there are more posts than fit on the view.' do
      visit user_posts_path(@user.id)
      expect(page).to have_button('Pagination')
    end

    it "When I click on a post, it redirects me to that post's show page." do
      visit user_posts_path(@user.id)
      all_posts = page.all('.post-link-container')
      all_posts.each do |post|
        visit post[:href]
        expect(response).to be nil
      end
    end
  end

  context '#Post show page:' do
    it "can see the post's title." do
      visit user_post_path(@user.id, @post1.id)
      expect(page).to have_css('.post-title-header', text: @post1.title.to_s)
    end

    it 'can see who wrote the post.' do
      visit user_post_path(@user.id, @post1.id)
      expect(page).to have_css('.poster-user-name', text: @user.name.to_s)
    end

    it 'see how many comments it has.' do
      visit user_post_path(@user.id, @post1.id)
      expect(page).to have_css('.comments-counter', text: "Comments: #{@post1.comments_counter}")
    end

    it 'can see how many likes it has.' do
      visit user_post_path(@user.id, @post1.id)
      expect(page).to have_css('.likes-counter', text: "Likes: #{@post1.likes_counter}")
    end

    it 'can see the post body.' do
      visit user_post_path(@user.id, @post1.id)
      expect(page).to have_css('.post-content-article', text: @post1.text.to_s)
    end

    it 'can see the username of each commentor.' do
      visit user_post_path(@user.id, @post1.id)
      all_comments = page.all('.comments-list-container')
      all_comments.each do |comment|
        expect(comment).to have_css('.commenter-user-name')
      end
    end

    it 'can see the comment each commentor left.' do
      visit user_post_path(@user.id, @post1.id)
      all_comments = page.all('.comments-list-container')
      all_comments.each do |comment|
        expect(comment).to have_css('.comments-content')
      end
    end
  end
end
