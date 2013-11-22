class RegisteredPlayer < Player
  include AutoNaming

  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable, :rememberable
  devise :database_authenticatable, :registerable, :recoverable, :trackable, :validatable

  validates :twitter_id, :uniqueness => true, :allow_blank => true

  before_save :sanitize_twitter_id

  private

  def sanitize_twitter_id
    return unless twitter_id.present?
    self.twitter_id = twitter_id[1..-1] if twitter_id.first == '@'
  end
end
