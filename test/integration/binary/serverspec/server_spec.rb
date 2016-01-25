# Encoding: utf-8
require 'serverspec'

set :backend, :exec

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
end

describe process('fabio') do
  it { should be_running }
end
