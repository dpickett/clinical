module Clinical
  class Contact
    include HappyMapper

    element :first_name, String
    element :middle_name, String
    element :last_name, String
    element :degrees, String
    element :phone, String
    element :phone_ext, String
    element :email, String
  end
end
