module Clinical
  class Contact
    include HappyMapper
    include Clinical::AbstractElement

    element :first_name, String
    element :middle_name, String
    element :last_name, String
    element :degrees, String
    element :phone, String
    element :phone_extension, String, :tag => "phone_ext"
    element :email, String


    def to_s
      [first_name, last_name, "(#{phone})"].join(" ")
    end
  end
end
