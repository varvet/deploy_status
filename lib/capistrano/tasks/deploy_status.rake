namespace :deploy do

  task :status do |t|
    require 'open-uri'
    system("git fetch -q")
    protocol = fetch(:protocol, 'http')
    port = fetch(:port, 80)
    on roles(:app) do |host|
      addr = "#{protocol}://#{host}:#{port}/deploy_status"
      open(addr, ssl_verify_mode: OpenSSL::SSL::VERIFY_NONE) do |f|
        status = f.read.gsub("\n","")
        branch = fetch(:branch, 'HEAD')
        remote_commit = status.split('|').first.split[1]
        local_hash = %x(git rev-parse --short origin/#{branch.to_s.shellescape}).strip
        local_commit = "#{branch}@#{local_hash}"
        puts "#{host} runs: #{remote_commit}, should run: #{local_commit}"
        if remote_commit != local_commit
          fail "Wrong commit is running, you should probably restart unicorn"
        end
      end
    end
  end

  task :set_current_version do
    on roles(:app) do
      within release_path do
        branch = fetch(:branch, 'HEAD')
        commit = capture("cd #{repo_path.to_s.shellescape} && git rev-parse --short #{branch.to_s.shellescape}")
        msg = "Branch: #{branch}@#{commit} | Release dir: #{release_timestamp} | Deployed by: #{local_user}"
        execute :echo, "'#{msg}' >> public/version"
      end
    end
  end

end
