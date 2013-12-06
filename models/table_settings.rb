class TableSettings < ActiveRecord::Base
  default_scope lambda { order 'created_at' }

  def self.current; last; end
end