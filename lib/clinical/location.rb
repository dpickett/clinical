module Clinical
  class Location
    include HappyMapper

    element :facility, String
    has_one :status, Clinical::Status, :parser => :parse
    has_one :contact, Clinical::Contact
    has_one :address, Clinical::Address
  end
end
