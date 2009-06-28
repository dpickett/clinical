module Clinical
  class Intervention
    include HappyMapper

    element :type, String, :tag => "intervention_type"
    element :description, String
    element :name, String, :tag => "intervention_name"

    def to_s
      "#{self.name} (#{self.type}): #{self.description}"
    end
  end
end
