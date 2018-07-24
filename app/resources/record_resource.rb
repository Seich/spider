class RecordResource < JSONAPI::Resource
  after_create :queue_crawl

  attributes :url, :crawled
  has_many :headers
  has_many :links

  def self.creatable_fields(context)
    super - [:crawled]
  end

  def self.updatable_fields(context)
    super - [:crawled]
  end

  def queue_crawl
    FetchRecordJob.perform_later @model
  end
end
