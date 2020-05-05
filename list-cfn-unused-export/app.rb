require "aws-sdk-cloudformation"

def list_exports(result = {}, next_token = nil)
  sleep 1
  resp = @client.list_exports(:next_token => next_token)
  resp.exports.each do |export|
    result[export.name] = { :value => export.value, :stack_id => export.exporting_stack_id }
  end
  list_exports(resp.next_token) if resp.next_token
  result
end

def list_imports(export_name, result = [], next_token = nil)
  sleep 1
  resp = @client.list_imports(:export_name => export_name, :next_token => next_token)
  result << resp.imports
  list_imports(export_name, result, resp.next_token) if resp.next_token
  result
rescue Aws::CloudFormation::Errors::ValidationError => e
  return [] if e.message.include?("is not imported by any stack")
  raise e
end

def list_stacks(result = {}, next_token = nil)
  sleep 1
  resp = @client.list_stacks(:next_token => next_token)
  resp.stack_summaries.each do |stack|
    result[stack.stack_id] = stack.stack_name
  end
  list_stacks(result, resp.next_token) if resp.next_token
  result
end

if __FILE__ == $0
  @client = Aws::CloudFormation::Client.new
  stacks = list_stacks
  exports = list_exports
  puts "following exports value is not used in any stack."
  exports.keys.each do |key|
    exports[key][:importing_stacks] = list_imports(key)
    puts "#{key} (defined in #{stacks[exports[key][:stack_id]]})" if exports[key][:importing_stacks].size == 0
  end
end