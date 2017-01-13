require 'open-uri'

gh_users = (ENV['GITHUB_USER'] || '').split(',')

gh_keys = if gh_users.size > 0
  gh_users.map { |u|
    open("https://github.com/#{u}.keys").read
  }.join("\n")
else
  nil
end

key_files = Dir.glob('/keys/**')
keys = if key_files.size > 0
  key_files.map { |f|
    open(f).read
  }.join("\n")
else
  nil
end

open('/staff/.ssh/authorized_keys', 'a') do |io|
  if keys
    puts 'Adding /keys...'
    io.puts "\n\n# From /keys\n\n"
    io.puts keys
  end

  if gh_keys
    puts "Adding keys from github.com/#{gh_users.join(',')}"
    io.puts "\n\n# From github.com/#{gh_users.join(',')}\n\n"
    io.puts gh_keys
  end
end

system('chmod 600 /staff/.ssh/authorized_keys')
