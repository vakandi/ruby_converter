#!/usr/bin/env ruby

# Check that a filename was provided as an argument
if ARGV.empty?
  puts "Usage: shell-to-ruby.rb <filename>"
  exit 1
end

# Read the contents of the shell script
filename = ARGV[0]
contents = File.read(filename)

# Convert the contents to a Ruby script
converted_contents = contents
  .gsub('$', '#') # Replace $ signs with #
  .gsub(/\b(echo|cat)\b/, 'puts') # Replace echo and cat commands with puts
  .gsub(/\b(mkdir|rm|touch)\b/, 'system') # Replace mkdir, rm, and touch commands with system
  .gsub(/^#!\/bin\/(bash|sh)/, '#!/usr/bin/env ruby') # Replace the shebang line with the Ruby shebang

# Write the converted script to a new file
File.write('converted.rb', converted_contents)

