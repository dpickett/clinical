require "test_helper"

class Clinical::TrialTest < Test::Unit::TestCase
  context "when finding based on a hash of conditions" do
    setup do
      register_response("/search?displayxml=true&start=1&recr=open", "open_set")
    end

    should "return a paginated list of trials" do
      @trials = Clinical::Trial.find({:conditions => {:recruiting => true}})
      assert_instance_of Clinical::Collection, @trials
    end
  end   
end
