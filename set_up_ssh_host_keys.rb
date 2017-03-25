HOST_KEYS = ENV['HOST_KEYS']

def create_host_key_if_not_exist(type, name)
  file_path = File.join(HOST_KEYS, name)
  unless File.exist?(file_path)
    system("ssh-keygen -t #{type}  -N '' -f #{file_path}")
  end
end

[
  %w(rsa ssh_host_rsa_key),
  %w(dsa ssh_host_dsa_key),
  %w(dsa ssh_host_ecdsa_key),
  %w(dsa ssh_host_ed25519_key),
].each do |type, name|
  system("mkdir -p #{HOST_KEYS}")
  create_host_key_if_not_exist(type, name)
end
