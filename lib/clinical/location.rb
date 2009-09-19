module Clinical
  class Location
    include HappyMapper
    include Clinical::AbstractElement

    element :facility, String
    has_one :status, Clinical::Status, :parser => :parse
    abstract_element :contact, Clinical::Contact
    has_one :address, Clinical::Address
  end
end
