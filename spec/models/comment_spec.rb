require 'rails_helper'

RSpec.describe Comment, type: :model do
  subject { Comment.new(text: 'Hello there!', post_id: 1, author_id: 1) }

  before { subject.save }

  it 'Should check if text column is present in comment' do
    subject.text = nil
    expect(subject).to_not be_valid
  end

  it 'Should check if text is not empty' do
    subject.text = ''
    expect(subject).to_not be_valid
  end

  it 'Should check the length of the comment not more than 255 characters' do
    subject.text = 'Hello' * 255
    expect(subject).to_not be_valid
  end

  it 'Should return the correct author as an instance of User' do
    expect(subject.author).to be_instance_of(User)
  end

  it 'Should return post as an instance of Post' do
    expect(subject.post).to be_instance_of(Post)
  end
end
