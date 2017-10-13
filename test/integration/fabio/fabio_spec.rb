# Encoding: utf-8
# require 'serverspec'

# set :backend, :exec

describe package('runit') do
  it { should be_installed }
end

describe file('/usr/local/bin/fabio') do
  it { should be_file }
end

describe file('/etc/service/fabio') do
  it { should be_symlink }
end

# as default attributes
describe file('/etc/sv/fabio/run') do
  it { should be_file }
end

describe file('/etc/fabio/fabio.properties') do
  it { should be_file }
  its('content') { should match %r{^.0xc02c,0xcc13,0xc030,0xc02b,0xc02f,0xc023,0xc027*/}}
end

describe file('/etc/pki/tls/private/fabio.key') do
  it { should be_file }
end

describe file('/etc/pki/tls/certs/fabio.pem') do
  it { should be_file }
end

describe user(fabio) do
  it { should exist }
end


describe service('fabio') do
  it { should be_running }
  it { should be_enabled }
  it { should be_running }
end


describe command('curl -v -H "Host: example.service" 127.1:9999/') do
  its(:stdout) { should match /google/ }
end
