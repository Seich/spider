class FetchRecordJob < ApplicationJob
  queue_as :default

  def perform(record)
    results = Wombat.crawl do
      base_url record.url
      headers do |h|
        h.h1 "css=h1", :list
        h.h2 "css=h2", :list
        h.h3 "css=h3", :list
      end

      links({xpath: "//a[starts-with(@href, 'http')]/@href"}, :list)
    end

    results["headers"].delete_if { |key, value| value.empty? }
    results["links"].delete_if &:empty?

    results["headers"].each_pair do |key, value|
      value.each do |h|
        record.headers << Header.new({content: h, level: key})
      end
    end

    results["links"].each do |l|
      record.links << Link.new({url: l})
    end

    record.crawled = true

    record.save
  end
end
