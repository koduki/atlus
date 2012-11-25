class Dashboard
  include Mongoid::Document
  field :name, :type => String
  field :orders, :type => String, :default => ""
  has_and_belongs_to_many :snipets, inverse_of: nil
end
