# require './log_parser'

# RSpec.describe LogParser, "#score" do
#   context 'with a valid log file' do
#     let(:valid_log_contents) { File.open(valid_log_file_path, "r") }
#     let(:valid_log_file_path) { File.expand_path("example_log_file.log", File.dirname(__FILE__)) }

#     subject { described_class.new(log_file_path: valid_log_file_path) }

#     context 'with valid content' do
#       it 'outputs the logs in order of most visited first' do
#         valid_output = "/help_page/1 had 4 visits\n"\
#                        "/about/2 had 4 visits\n"\
#                        "/home had 2 visits\n"\
#                        "/contact had 1 visits\n"
#         expect { subject.parse_and_output_sorted_logs }.to output(/#{Regexp.quote(valid_output)}/).to_stdout
#       end

#       it 'outputs the logs in order of most unique visits first' do
#         valid_output = "/help_page/1 had 3 unique visits\n"\
#                        "/home had 2 unique visits\n"\
#                        "/contact had 1 unique visits\n"\
#                        "/about/2 had 1 unique visits\n"
#         expect { subject.parse_and_output_sorted_logs }.to output(/#{Regexp.quote(valid_output)}/).to_stdout
#       end
#     end
#   end
# end
