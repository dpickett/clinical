module Clinical
  class Status
    STATUSES = [
      :not_yet_recruiting, 
      :recruiting,
      :enrolling_by_invitation,
      :active,
      :not_recruiting, 
      :completed, 
      :suspended, 
      :terminated, 
      :withdrawn, 
      :available, 
      :no_longer_available
    ]

    OPEN_STATUSES = [
      :not_yet_recruiting,
      :recruiting
    ]

    attr_reader :name

    def initialize(sym)
      @name = sym
    end

    def open?
      OPEN_STATUSES.include?(name)
    end

    def to_s
      @name.to_s
    end

    class << self
      def parse(s)
        s.nil? ? nil : Status.new(s.downcase.gsub(" ", "_").to_sym)
      end
    end
  end
end
