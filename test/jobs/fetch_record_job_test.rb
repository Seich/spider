require "test_helper"

class FetchRecordJobTest < ActiveJob::TestCase
  def setup
    @record = records(:first)

    raw_response_file = File.new("./test/requests/blogpost.txt")
    WebMock.stub_request(:get, "http://martianwabbit.com/2018/05/25/testing-oclif-with-jest.html")
      .to_return(raw_response_file)
  end

  test "It should grab the headers for the given record" do
    assert_difference "@record.headers.count", 2 do
      FetchRecordJob.perform_now(@record)
    end
  end

  test "It should grab the links for the given record" do
    assert_difference "@record.links.count", 2 do
      FetchRecordJob.perform_now(@record)
    end
  end

  test "It should set the record to crawled once it is done" do
    assert_changes "@record.crawled", from: false, to: true do
      FetchRecordJob.perform_now(@record)
    end
  end
end
