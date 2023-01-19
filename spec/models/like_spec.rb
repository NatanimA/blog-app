require 'rails_helper'

RSpec.describe Like, type: :model do
  subject { Like.new(author_id: 1, post_id: 1) }

  before { subject.save }

  it 'Should return the author as instance of User' do
    expect(subject.author).to be_instance_of(User)
  end

  it 'Should return the post as an instance of Post' do
    expect(subject.post).to be_instance_of(Post)
  end
end
