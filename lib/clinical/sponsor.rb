module Clinical
  module Sponsor
     def self.included(base)
        base.class_eval do
          attr_accessor :name
          include HappyMapper
        end
        base.extend(ClassMethods)
        base.send(:include, InstanceMethods)
      end

    module InstanceMethods
      def to_s
        name
      end
    end
    module ClassMethods
      def parse(xml, options = {})
        xml.find(tag_name).collect do |n|
          item = new
          item.name = n.content.chomp.strip
          item
        end
      end
    end
  end
end