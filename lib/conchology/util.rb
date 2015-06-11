module Conchology
  module Util
    def self.io_to_a(io)
      io.readlines.collect { |x| x.chomp }
    end
  end
end
