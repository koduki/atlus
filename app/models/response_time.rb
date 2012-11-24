class ResponseTime
  include Mongoid::Document
  field :domain, :type => String
  field :datetime, :type => Time
  field :response, :type => Float
  field :count, :type => Integer
end
