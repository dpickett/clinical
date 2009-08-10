module Clinical
  class Trial
    include HappyMapper
    include HTTParty

    base_uri "http://clinicaltrials.gov"
    default_params :displayxml => true 

    tag "clinical_study"
    element :nct_id, String, :deep => true
    element :read_status, Clinical::Status, :tag => "status", :parser => :parse
    element :overall_status, Clinical::Status, :parser => :parse
    element :url, String    
    element :short_title, String, :tag => "title"
    element :official_title, String
    element :condition_summary, String
    has_many :condition_items, Clinical::Condition, :tag => "condition", :raw => true

    element :text_phase, String, :tag => "phase"
    element :study_type, String
    element :study_design, String

    has_one :lead_sponsor, Clinical::LeadSponsor
    has_many :collaborators, Clinical::Collaborator
    has_many :agencies, Clinical::Agency

    has_one :overall_official, Clinical::OverallOfficial, :tag => "overall_official"

    has_many :interventions, Intervention, :tag => "intervention"
    has_many :primary_outcomes, PrimaryOutcome
    has_many :secondary_outcomes, SecondaryOutcome

    has_many :locations, Location, :tag => "location"
    element :start_date, Date
    element :end_date, Date

    element :first_received_at, Date, :tag => "firstreceived_date"
    element :updated_at, Date, :tag => "lastchanged_date"

    element :minimum_age, String, :tag => "eligibility/minimum_age"
    element :maximum_age, String, :tag => "eligibility/maximum_age"
    element :gender, String, :tag => "eligibility/gender"
    element :healthy_volunteers, String, :tag => "eligibility/healthy_volunteers"

    element :participant_quantity, Integer, :tag => "enrollment"

    element :url, String, :tag => "required_header/url"
    element :eligibility_criteria, String, :tag => "eligibility/criteria/textblock"

    element :brief_summary, String, :tag => "brief_summary/textblock"
    element :detailed_description, String, :tag => "brief_summary/textblock"

    attr_reader :keywords
    attr_reader :categories
    attr_reader :terms

    def id
      self.nct_id
    end

    def open?
      self.status && self.status.open?
    end

    def sponsors
      @sponsors ||= [lead_sponsor, (collaborators || []), (agencies || [])].flatten
    end

    def outcomes
      @outcomes ||= [primary_outcomes, secondary_outcomes].flatten
    end

    def status
      self.read_status || self.overall_status
    end

    def conditions
      if condition_items.nil? || condition_items.empty?
        condition_summary.nil? ? nil : condition_summary.split(";")
      else
        condition_items
      end
    end

    def phase
      self.text_phase.gsub(/phase /i, "").to_i
    end

    #this metadata is not accessible in the feed so crawl the html page
    #to get keywords, categories, and terms
    def get_metadata
      response = self.class.get("/show/#{id}", :query => {:displayxml => false})
      html = Nokogiri::HTML(response.body)

      metadata = {}

      {
        :terms => 0, 
        :categories => 1,
        :keywords => 2
      }.each do |key, value|

        metadata[key] = []
        html.search("div.indent3:nth-last-child(#{value}) td").each do |td|
          word = td.inner_html.split(/\<br\>/).collect{|i| i.gsub(/\<div.*/, "").strip}
          if word != ""
            metadata[key] += word
          end
        end

      end

      @terms, @categories, @keywords = metadata[:terms], metadata[:categories], metadata[:keywords]
      metadata
    end

    class << self
      def find_by_id(id)
        response = get("/show/#{id}")
        if response.code == 400
          nil
        else
          begin
            parse(response.body)
          rescue LibXML::XML::Error
            return nil
          end 
        end
      end

      def find(*args)
        options = args.extract_options!

        options[:page] ||= 1
        options[:per_page] ||= 20

        query = query_hash_for(*[args, options])
        response = get("/search", :query => query)
        trials = Collection.create_from_results(options[:page], 
          options[:per_page], 
          response.body)

        if options[:extended]
          fetch_more_details(trials)
        else
          trials
        end
      end

      def query_hash_for(*args)
        query = {}
        options = args.extract_options! || {}
        
        conditions = options[:conditions] || {}
        query["start"] = (options[:per_page] * options[:page]) - (options[:per_page] - 1)
        unless conditions[:recruiting].nil?
          query["recr"] = conditions[:recruiting] ? "open" : "closed" 
        end
        query["term"] = args.first if args.first.is_a?(String)
        
        {
          :condition => "cond", 
          :sponsor => "spons",
          :intervention => "intr",
          :outcome => "outc",
          :sponsor => "spons"
        }.each do |key,value|
          query[value] = conditions[key] unless conditions[key].nil?
        end

        unless conditions[:updated_at].nil?
          unless conditions[:updated_at].is_a?(Array)
            conditions[:updated_at] = [conditions[:updated_at]] 
          end

          query["lup_s"] = conditions[:updated_at][0].strftime("%m/%d/%Y")
          if conditions[:updated_at].size == 2
            query["lup_e"] = conditions[:updated_at][1].strftime("%m/%d/%Y") 
          end
        end

        query
      end

      def extract_options!
        last.is_a?(Hash) ? pop : { }
      end
      
      private
      def fetch_more_details(trials)
        detailed_trials = trials.collect {|i| find_by_id(i.id)}
        Collection.create(trials.current_page, trials.per_page, trials.count || 0) do |pager|
          pager.replace(detailed_trials)
        end
      end
    end
  end
end
