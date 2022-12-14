class Post < ApplicationRecord
  belongs_to :author, class_name: 'User', foreign_key: 'author_id'
  has_many :comments
  has_many :likes
  after_save :update_post_counter

  def update_post_counter
    author.increment!(:posts_counter)
  end

  def recents_comments
    comments.order(created_at: :desc).limit(5)
  end
end
