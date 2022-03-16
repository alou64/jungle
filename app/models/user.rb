class User < ActiveRecord::Base
  has_secure_password

  def self.authenticate_with_credentials(email, password)
    user = User.find_by_email(email)
    if user && user.authenticate(password)
      user
    else
      nil
    end
  end

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :password, length: { minimum: 6 }
  validates :email, :uniqueness => { :case_sensitive => false }, presence: true, on: :create
end
