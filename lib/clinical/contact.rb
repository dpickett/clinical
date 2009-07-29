module Clinical
  module Contact
    def self.included(base)
      base.class_eval do
        include HappyMapper
        include Clinical::Contact::InstanceMethods

        element :first_name, String
        element :middle_name, String
        element :last_name, String
        element :degrees, String
        element :phone, String
        element :phone_extension, String, :tag => "phone_ext"
        element :email, String
      end

    end

    module InstanceMethods
      def to_s
        [first_name, last_name, "(#{phone})"].join(" ")
      end
    end
  end
end
