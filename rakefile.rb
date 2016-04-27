
def soft_link(source, dst)
  sh "rm -fr #{dst}"
  sh "ln -s #{File.expand_path(source)} #{File.expand_path(dst)}"
end

namespace :rubocop do
  desc 'create link for rubocop to fineart'
  task :fineart do
    soft_link "#{pwd}/rubocop.yml", "#{pwd}/../fineart/.rubocop.yml"
  end

  desc 'create link for rubocop to auktion'
  task :auktion do
    soft_link "#{pwd}/rubocop.yml", "#{pwd}/../auktion/.rubocop.yml"
  end
end
