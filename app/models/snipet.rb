class Snipet
  include Mongoid::Document
  field :name, :type => String
  field :query, :type => String
  field :chartType, :type => String
  field :isTableVisible, :type => Boolean
  field :isChartVisible, :type => Boolean
end
