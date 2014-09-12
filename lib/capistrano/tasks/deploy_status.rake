namespace :deploy do

  task :status do |t|
    require 'open-uri'
    system("git fetch -q")
    on roles(:app) do |host|
      open("http://#{host}:80/deploy_status", ssl_verify_mode: OpenSSL::SSL::VERIFY_NONE) do |f|
        status = f.read.gsub("\n","")
        branch = fetch(:branch, 'HEAD')
        remote_commit = status.split('|').first.split[1]
        local_commit = %x(git rev-parse --short origin/#{branch.to_s.shellescape})
        puts "#{host} runs: #{remote_commit}, should run: #{branch}@#{local_commit}"
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
