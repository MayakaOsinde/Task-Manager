# class User < ActiveRecord::Base
#     has_many :tasks
#     validates :email, presence: true, uniqueness: true
#     validates :password_digest, presence: true
#     has_secure_password

# end


class User < ActiveRecord::Base
  validates :first_name, :last_name, :email, :age, :password_digest, presence: true
  validates :email, uniqueness: true
  validates :email, format: { with: /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i }
  validates :age, numericality: { greater_than: 0, less_than: 150 }

  has_secure_password
end

