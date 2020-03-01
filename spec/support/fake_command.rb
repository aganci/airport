require 'simple_command/errors'

class FakeCommand
  attr_reader :result, :errors
  attr_accessor :success
  
  def initialize result_value = nil
    @result = result_value
    @success = true
  end

  def set_error key, text
    @errors ||= SimpleCommand::Errors.new
    @errors.add(key, text)
    @success = false
  end

  def success?
    @success
  end
end