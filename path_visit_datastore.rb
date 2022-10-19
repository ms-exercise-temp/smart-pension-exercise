require 'set'
require './path_visit_data'

class PathVisitDatastore
  attr_reader :path_visits

  InvalidLogLineError = Class.new(StandardError).freeze;

  def initialize
    @path_visits = {}
  end

  def update_path_visit_quantities(log_line:)
    raise(InvalidLogLineError, "Invalid log line") unless log_line.is_a? LogLine

    @path_visits.update(initial_entry(log_line))
  end

  private

  def initial_entry(log_line)
    { "#{log_line.path}": PathVisitData.new(visit_count: 1, unique_visit_count: 1) }
  end
end
