require 'socket'

s = UNIXSocket.open('/Users/igakuratakayuki/RubyWorkspace/jmaclient/tmp/jmaclient_receiver.socket')
f = open("sample02")
s.write(f.read)
f.close
s.close
