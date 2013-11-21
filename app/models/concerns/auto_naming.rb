module AutoNaming
  # TODO: check if we need a DummyPlayer class to manage not registered players,
  # instead of this crap
  extend ActiveSupport::Concern

  included do |base|
    validates :name, :presence => true
    before_validation :set_dummy_name
  end

  private

  def set_dummy_name
    self.name ||= dummy_name
  end

  def dummy_name
    ('a'..'z').to_a.sample(8).join
  end
end