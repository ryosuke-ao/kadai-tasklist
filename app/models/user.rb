class User < ApplicationRecord
  before_save { self.email.downcase! }
  validates :name, presence: true, length: { maximum: 50 }
  validates :email, presence: true, length: { maximum: 255 },
                    format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i },
                    uniqueness: { case_sensitive: false }
  has_secure_password

  has_many :tasks
  has_many :favorites
  has_many :tofavs, through: :favorites, source: :task
  
  def fav(task)
    self.favorites.find_or_create_by(task_id: task.id)
  end
  
  def unfav(task)
    favorite = self.favorites.find_by(task_id: task.id)
    favorite.destroy if favorite
  end
  
  def fav?(task)
    self.tofavs.include?(task)
  end
  
end
