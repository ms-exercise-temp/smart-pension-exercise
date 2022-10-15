class LogLine
  attr_reader :path
  attr_reader :ip_address

  InvalidLogLineError = Class.new(StandardError).freeze;

  def initialize(line_contents:)
    @line_contents = line_contents
    @path, @ip_address = ordered_values
  end

  private

  def ordered_values
    raise(InvalidLogLineError "Invalid log line") unless @line_contents.split.size == 2

    @line_contents.split
  end
end
