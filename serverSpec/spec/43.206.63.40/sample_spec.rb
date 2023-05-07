require 'spec_helper'

listen_port = 80

#gitインストール確認
describe package('git') do
  it { should be_installed }
end

#nginx起動確認
describe service('nginx') do
  it { should be_running }
end

#unicorn動作確認
describe command("ps aux | grep unicorn" ) do
  its(:stdout) { should contain("unicorn master") }
end

#ALB_DNSでアクセスして200OKが返ってくるかの確認
describe command("curl http://#{ENV['ALB_DNS']}/ -o /dev/null -w \"%{http_code}\\n\" -s") do
its(:stdout) { should match /^200$/ }
end