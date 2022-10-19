require './log_parser'

log_file_path = ARGV[0]

raise "Error: A file does not exist at #{log_file_path}." unless File.file?(log_file_path)

LogParser.new(log_file_path: log_file_path).parse_and_output_sorted_logs
