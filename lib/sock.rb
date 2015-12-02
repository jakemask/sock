require 'socket'
require 'colorize'

##
# Sock is a helper class for using tcp sockets in an easily debuggable way.
#
class Sock
  ## Constructor

  def initialize(host, port, debug = false)
    @sock = TCPSocket.new host, port
    @debug = debug
  end

  ## Methods

  def write(str)
    print str.magenta if @debug
    @sock.write(str)
  end

  def writeline(str)
    send(str + "\n")
  end

  alias_method :send, :write
  alias_method :sendline, :writeline

  alias_method :put, :write
  alias_method :putline, :writeline

  def read(nbytes)
    msg = @sock.recv nbytes
    print msg.cyan if @debug
    msg
  end

  def readline
    msg = @sock.readline
    print msg.cyan if @debug
    msg
  end

  alias_method :recv, :read
  alias_method :recvline, :readline

  alias_method :get, :read
  alias_method :getline, :readline

  def go_interactive
    loop do
      return unless write_out
      return unless read_in
      IO.select([@sock, STDIN], [], [@sock, STDIN])
    end
  end

  def write_out(data = nil)
    STDOUT.write(data) while (data = @sock.read_nonblock(100)) != ''
    return false
  rescue Errno::EAGAIN
    return true
  rescue EOFError
    @sock.close
    return false
  end
  private :write_out

  def read_in(data = nil)
    @sock.write(data) while (data = STDIN.read_nonblock(100)) != ''
    return true
  rescue Errno::EAGAIN
    return true
  rescue EOFError
    return false
  end
  private :read_in

  def close
    @sock.close
  end

  ## Static

  def self.connect(host, port, debug = false)
    s = Sock.new(host, port, debug)
    yield s
    s.close
  end
end
