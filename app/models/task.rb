class Task < ApplicationRecord
  belongs_to :user
  validates :content, presence: true, length: { maximum: 255 }
  validates :status, presence: true, length: { maximum: 10 }
  
  has_many :favorites
  has_many :reverses_of_favorite, class_name: 'Favorites', foreign_key: 'task_id'
  has_many :faveds, through: :reverses_of_favorite, source: :user
end


  