require 'pry-byebug'

class PathVisitDataReader
  def initialize(data_store:)
    @data_store = data_store
  end

  def paths_by_visit_count
    arr = []
    @data_store.paths_by_visit_count.each do |path, path_visit_data|
      arr << "#{path} had #{path_visit_data.visit_count} visits"
    end
    arr
  end

  def paths_by_unique_visit_count
    arr = []
    @data_store.paths_by_unique_visit_count.each do |path, path_visit_data|
      arr << "#{path} had #{path_visit_data.unique_visit_count} unique visits"
    end
    arr
  end
end
