require 'open4'
require 'conchology/version'
require 'conchology/util'

module Conchology
  class Command
    attr_reader :output, :error, :exitstatus, :command

    def initialize( command  )
      @command = command
      @output = Array.new
      @error = Array.new
      @exitstatus=-1
    end

    def run
      pid, stdin, stdout, stderr = Open4::popen4 "#{ @command }"
      status = Process::waitpid2(pid)[1] 
      @exitstatus = ( status.to_i / 256 )
      @output += Util.io_to_a(stdout)
      @error += Util.io_to_a(stderr)
      self.to_h
    end

    def to_h
      {
        :exitstatus => @exitstatus, 
        :output => @output,
        :error => @error
      }
    end

    def self.run(command)
      self.new(command).run
    end
  end
end

