module Clinical
  class Collection < WillPaginate::Collection
    include HappyMapper
    class << self
      def create_from_results(page, per_page, body)
        results = SearchResult.parse(body)
        create(page, per_page, results.count || 0) do |pager|
          pager.replace(results.trials)
        end
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
