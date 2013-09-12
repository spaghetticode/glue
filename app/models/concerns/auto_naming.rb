module AutoNaming
  extend ActiveSupport::Concern

  included do |base|
    validates :name, :presence => true
    before_validation :set_dummy_name
  end

  private

  def set_dummy_name
    self.name = dummy_name unless name.present?
  end
end