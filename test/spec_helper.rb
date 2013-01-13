require 'open3'

def run env, cmd
  ignored_output, status = Open3::capture2e(env, cmd)
  # It's really handy for debugging to uncomment this line.
#  puts ignored_output
  status
end
