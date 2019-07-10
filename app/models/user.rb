class User < ActiveRecord::Base

  has_many :posts
  has_many :categories, through: :posts
  validates_presence_of :name, :email
  validates :email, uniqueness: true
  include BCrypt


  def password
    @password ||= Password.new(password_hash)


  end


  def password=(new_password)
    @password = Password.create(new_password)
    self.password_hash = @password

  end
end