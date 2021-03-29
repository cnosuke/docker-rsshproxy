require 'open-uri'

AUTHORIZED_KEYS_PATH = '/authorized_keys'

passed_authorized_keys_path = ENV['AUTHORIZED_KEYS_PATH'] || ''
if File.exist?(passed_authorized_keys_path)
  system("cat #{passed_authorized_keys_path} >> #{AUTHORIZED_KEYS_PATH}")
end

gh_users = (ENV['GITHUB_USER'] || '').split(',')

gh_keys = unless gh_users.empty?
            gh_users.map do |u|
              key_url = "https://github.com/#{u}.keys"
              begin
                URI.open(key_url).read
              rescue OpenURI::HTTPError => e
                warn "[WARN]: #{e.message} while opening #{key_url}, #{u}'s key is ignored'"
                nil
              end
            end.compact.join("\n")
          end

key_files = Dir.glob('/keys/**')
keys = unless key_files.empty?
        key_files.map do |f|
          open(f).read
        end.join("\n")
       end

open(AUTHORIZED_KEYS_PATH, 'a') do |io|
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

system("chmod 600 #{AUTHORIZED_KEYS_PATH}")
