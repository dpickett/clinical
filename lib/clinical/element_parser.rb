module Clinical
  class ElementParser
    class << self
      def parse_status(s)
        s.nil? ? nil : s.downcase.gsub(" ", "_").to_sym
      end
    end
  end
end
