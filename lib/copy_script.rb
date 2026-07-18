require 'optparse'
require_relative 'copy'

options = {}
OptionParser.new do |opts|
  opts.banner = "Usage: copy.rb [options]"

  opts.on("-s SOURCE", "--source SOURCE", "Source directory") do |source|
    options[:source] = source
  end

  opts.on("-d [DESTINATION]", "--destination [DESTINATION]", "Destination directory") do |destination|
    options[:destination] = destination
  end

end.parse!

options.fetch(:source) do
    raise OptionParser::MissingArgument, "source directory is required"
end 
options.fetch(:destination, "./dist")

Copy.copy(options[:source], options[:destination])