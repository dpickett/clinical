module Clinical
  class Address
    include HappyMapper

    element :city, String
    element :state, String
    element :zip, String
    element :country, String
  end
end
