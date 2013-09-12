module FactoryMethods
  %w[team player].each do |name|
    define_method "create_#{name}" do |opts={}|
      FactoryGirl.create name, opts
    end
  end
end
