class UnauthorizedError < StandardError

  def initialize(msg)
    super(msg)
  end
end
