module Clinical
  module Outcome

    def self.included(base)
      base.send(:include, InstanceMethods)
      base.class_eval do
        include InstanceMethods
        include HappyMapper
        element :measure, String
        element :time_frame, String
        element :safety_issue, String
      end
    end
    
    module InstanceMethods
      def primary?
        self.class.tag_name == "primary_outcome"
      end

      def to_s
        val = "#{measure}"
        val << ", TIME FRAME: #{time_frame}" if time_frame
        val << ",SAFETY ISSUE: #{safety_issue}" if safety_issue
        val
      end
    end
    
  end
end
