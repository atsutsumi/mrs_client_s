require 'socket'

s = UNIXSocket.open('/tmp/jmaclient.sock')
f = open("sample")
s.write(f.read)
f.close
s.close
