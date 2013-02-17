class Book
  include Mongoid::Document
  field :isbn, :type => String
  field :title, :type => String
  field :author, :type => String
  field :seriesName, :type => String
  field :publishName, :type => String
  field :genre, :type => String
  field :salesDate, :type => String
end
