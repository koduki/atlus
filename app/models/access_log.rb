class AccessLog
  include Mongoid::Document
  field :host, :type => String
  field :user, :type => String
  field :method, :type => String
  field :path, :type => String
  field :code, :type => Integer
  field :size, :type => Integer
  field :referer, :type => String
  field :agent, :type => String
  field :time, :type => Time
end
