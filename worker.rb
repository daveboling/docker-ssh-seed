require 'net/ssh'

Net::SSH.start('localhost', 'root', port: '5000', password: 'password') do |ssh|
  puts ssh.exec!("~/../app/bin/etl")
end
