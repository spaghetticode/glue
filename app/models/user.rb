class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # FIXME: not sure this is what I want. We need to register players, and players should be allowed to log in.
  # Player model already exists, so that model should be enhanched with devise. User model is basically useless.
end
