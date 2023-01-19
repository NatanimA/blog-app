require 'rails_helper'

RSpec.describe Post, type: :model do
  subject do
    Post.new(title: 'How I became self taught programmer.',
             text: 'This is how I became the most amazing developer in history',
             comments_counter: 0,
             likes_counter: 0,
             author_id: 1)
  end

  before { subject.save }

  it 'Should check title not to be nil' do
    subject.title = nil
    expect(subject).to_not be_valid
  end

  it 'Should check if title is empty string' do
    subject.title = ''
    expect(subject).to_not be_valid
  end

  it 'should check if title is greater than 255 characters' do
    subject.title = 'test' * 100
    expect(subject).to_not be_valid
  end

  it 'should check comments counter to not be NIL value' do
    subject.comments_counter = nil
    expect(subject).to_not be_valid
  end

  it 'Should check comments_counter to be integer value only' do
    subject.comments_counter = 'AbCD'
    expect(subject).to_not be_valid
  end

  it 'Should check if comments_counter is not negative' do
    subject.comments_counter = -10
    expect(subject).to_not be_valid
  end

  it 'Should check for nil value in likes counter' do
    subject.likes_counter = nil
    expect(subject).to_not be_valid
  end

  it 'should check for string value in likes couner' do
    subject.likes_counter = 'ABCD'
    expect(subject).to_not be_valid
  end

  it 'Should check for negative number in likes counter' do
    subject.likes_counter = -10
    expect(subject).to_not be_valid
  end

  it 'Should instatiate comments with empty list' do
    expect(subject.comments).to be_empty
  end

  it 'Should insert new comments to the comment list' do
    comment = Comment.new(text: 'Hello there!', post_id: 1, author_id: 1)
    subject.comments << comment
    expect(subject.comments).to contain_exactly(an_object_having_attributes(text: 'Hello there!'))
  end

  it 'Should instantiate likes with empty list' do
    expect(subject.likes).to be_empty
  end

  it 'Should insert new likes to the likes list' do
    like = Like.new(author_id: 1, post_id: 1)
    subject.likes << like
    expect(subject.likes).to contain_exactly(an_object_having_attributes(author_id: 1))
  end
end
