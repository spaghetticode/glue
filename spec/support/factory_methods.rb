module FactoryMethods
  %w[team player match].each do |name|
    define_method "create_#{name}" do |opts={}|
      FactoryGirl.create name, opts
    end

    define_method "build_#{name}" do |opts={}|
      FactoryGirl.build name, opts
    end
  end
end
