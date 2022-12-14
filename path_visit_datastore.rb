require 'set'
require './path_visit_data'

class PathVisitDatastore
  attr_reader :path_visits
  attr_reader :visited_paths

  InvalidLogLineError = Class.new(StandardError).freeze;

  def initialize
    @path_visits = {}
    @visited_paths = Set.new
  end

  def paths_by_visit_count
    @path_visits.sort_by { |key, value| -value.visit_count }
  end

  def paths_by_unique_visit_count
    @path_visits.sort_by { |key, value| -value.unique_visit_count }
  end

  def update_path_visit_quantities(log_line:)
    raise(InvalidLogLineError, "Invalid log line") unless log_line.is_a? LogLine

    is_unique_visit = !store_unique_log_entry(log_line).nil?

    @path_visits.update(initial_entry(log_line)) do |key, path_visit_data|
      path_visit_data.increment_stats(is_unique_visit: is_unique_visit)
    end
  end

  private

  def initial_entry(log_line)
    { "#{log_line.path}": PathVisitData.new(visit_count: 1, unique_visit_count: 1) }
  end

  def store_unique_log_entry(log_line)
    @visited_paths.add?([log_line.path, log_line.ip_address])
  end
end
