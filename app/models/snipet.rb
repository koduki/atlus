class Snipet
  include Mongoid::Document
  field :name, :type => String
  field :query, :type => String
  field :chartType, :type => String
  field :width, :type => Integer, :default => 600
  field :height, :type => Integer, :default => 384
  field :isTableVisible, :type => Boolean
  field :isChartVisible, :type => Boolean
  field :scale, :type => Integer, :default => 1
end
