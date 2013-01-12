require 'open3'

def run env, cmd
  ignored_output, status = Open3::capture2e(env, cmd)
  status
end
