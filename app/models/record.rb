class Record < ApplicationRecord
  has_many :links
  has_many :headers
end
