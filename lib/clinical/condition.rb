module Clinical
  class Condition
    attr_accessor :name
    include HappyMapper

    def to_s
      self.name || ""
    end

    class << self
      def parse(xml, options)
        xml.find("condition").collect do |n|
          item = new
          item.name = n.content.chomp.strip
          item
        end
      end
    end
  end
end
