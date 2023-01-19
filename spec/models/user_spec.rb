require 'rails_helper'

RSpec.describe User, type: :model do
  subject do
    User.new(name: 'Natanim Abesha',
             photo: 'https://www.pexels.com/photo/abandoned-ancient-antique-architecture-235986/',
             bio: 'Neo is an Ethiopian app developer cum reality TV star, television personality,
      entrepreneur, and entertainer. He is known for being one of the housemates of the season 5
      Lockdown edition of the popular Nigerian reality TV
      show named Big Brother Naija premiered in 2020.',
             posts_counter: 0)
  end

  before { subject.save }

  it 'Name should be present' do
    subject.name = nil
    expect(subject).to_not be_valid
  end

  it 'Name should not be empty string' do
    subject.name = ''
    expect(subject).to_not be_valid
  end

  it 'Posts Counter must be an Integer and greater than 0' do
    subject.posts_counter = -1
    expect(subject).to_not be_valid
  end

  it 'Posts counter must not accept a String as a parameter' do
    subject.posts_counter = 'Neo'
    expect(subject).to_not be_valid
  end

  it 'Posts Counter must accept Integer greater than 0' do
    subject.posts_counter = 19
    expect(subject).to be_valid
  end

  it 'Should Instantiate Posts with empty List' do
    expect(subject.posts).to match_array([])
  end

  it 'Should Add posts to the list' do
    post = Post.create(title: 'How I became self taught programmer.', text: "This is how I
    became the most amazing developer in history", comments_counter: 0, likes_counter: 0, author_id: 1)
    subject.posts << post
    expect(subject.posts.length).to be(1)
  end

  it 'Should instantiate Likes with empty list' do
    expect(subject.likes).to match_array([])
  end

  it 'Should be able to Insert Likes object into list' do
    likes = Like.new(author_id: 1, post_id: 1)
    subject.likes << likes
    expect(subject.likes).to contain_exactly(an_object_having_attributes(post_id: 1))
  end

  it 'Should Instantiate Comments with empty array of objects' do
    expect(subject.comments).to match_array([])
  end

  it 'Should Insert new comments to list' do
    comment = Comment.new(text: 'Hello there!', post_id: 1, author_id: 1)
    subject.comments << comment
    expect(subject.comments).to contain_exactly(an_object_having_attributes(text: 'Hello there!'))
  end
end
