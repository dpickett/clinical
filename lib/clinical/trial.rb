require "ruby-debug"

module Clinical
  class Trial
    include HappyMapper
    include HTTParty

    base_uri "http://clinicaltrials.gov"
    default_params :displayxml => true 

    tag "clinical_study"
    element "nct_id", String
    element "url", String    
    element "title", String
    element "condition_summary", String
    element "last_changed", Date
    element "status", Clinical::ElementParser, :parser => :parse_status

    class << self
      def find(*args)
        options = args.extract_options!

        options[:page] ||= 1
        options[:per_page] ||= 20

        query = query_hash_for(*[args, options])
        response = get("/search", :query => query)
        Collection.create_from_results(options[:page], options[:per_page], response.body)
      end

      def query_hash_for(*args)
        query = {}
        options = args.extract_options! || {}

        
        conditions = options[:conditions] || {}
        query["start"] = (options[:per_page] * options[:page]) - (options[:per_page] - 1)
        query["recr"] = conditions[:recruiting] ? "open" : "closed" if conditions[:recruiting]
        query["term"] = args.first if args.first.is_a?(String)
        query
      end

      def extract_options!
        last.is_a?(Hash) ? pop : { }
      end
      
    end
  end
end
