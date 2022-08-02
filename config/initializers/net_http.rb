# frozen_string_literal: true

File.write('/tmp/adsnap-admin.pem', File.read(NetHttpSslFix::LOCAL_CA_FILE))

Kernel.silence_warnings do
  NetHttpSslFix.const_set(:LOCAL_CA_FILE, '/tmp/adsnap-admin.pem')
end
