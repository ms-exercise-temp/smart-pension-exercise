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

  def update_path_visit_quantities(log_line:)
    raise(InvalidLogLineError, "Invalid log line") unless log_line.is_a? LogLine

    store_unique_log_entry(log_line)
    @path_visits.update(initial_entry(log_line))
  end

  private

  def initial_entry(log_line)
    { "#{log_line.path}": PathVisitData.new(visit_count: 1, unique_visit_count: 1) }
  end

  def store_unique_log_entry(log_line)
    @visited_paths.add?([log_line.path, log_line.ip_address])
  end
end
