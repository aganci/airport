class FakeCommand
  attr_reader :result
  
  def initialize result_value
    @result = result_value
  end
end