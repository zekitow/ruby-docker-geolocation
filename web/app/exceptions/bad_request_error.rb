class BadRequestError < StandardError

  def initialize(msg)
    super(msg)
  end
end
