module PJBank
  class Exception < StandardError
    attr_accessor :code, :body

    def initialize(args = {})
      super(args[:message])
      @code = args[:code]
      @body = args[:body]
    end
  end
end
