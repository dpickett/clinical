module Clinical
  class Collection < WillPaginate::Collection
    include HappyMapper
    attr_accessor :count
    class << self
      def create_from_results(page, per_page, body)
        results = SearchResult.parse(body)
        col = create(page, per_page, results.count || 0) do |pager|
          pager.replace(results.trials)
        end
        col.count = results.count
        col
      end
    end
    
    class SearchResult
      include HappyMapper
      tag "search_results"
      attribute "count", Integer

      has_many :trials, Clinical::Trial
    end
  end
end
