require 'singleton'
require 'digest/md5'

class DataManager
  include Singleton

  def initialize
    @cache = {}
  end

  def execute query
    key = Digest::MD5.hexdigest query
    if @cache.key? key
      @cache[key]
    else
      @cache[key] = eval(query)
      @cache[key]
    end
  end

  def update query
    key = Digest::MD5.hexdigest query
    @cache[key] = eval(query)
    @cache[key]
  end

end
