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

  context "a trial" do
    setup do
      @npi_id = "NPI5245"
      register_response("/show/NPI5245?displayxml=true", "lupus_single")
      @trial = Clinical::Trial.find_by_id(@npi_id)
    end

    should "have a status" do
      assert_not_nil @trial.status
    end

    should "indicate whether the trial is open" do
      assert_equal @trial.open?, @trial.status.open?
    end

    should "have a location" do
      assert_not_nil @trial.locations
      assert !@trial.locations.empty?
    end

    should "have a start date" do
      assert_not_nil @trial.start_date
    end

    should "have a location with an address" do
      assert !@trial.locations[0].address.nil?
    end

    should "have a study type" do
      assert_not_nil @trial.study_type
    end
  end

end
