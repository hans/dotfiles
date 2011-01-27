require 'rake'

# from http://errtheblog.com/posts/89-huba-huba
# rakefile-ized by Hans Engel (http://engel.uk.to)

desc "Copy dotfiles into the current user's home directory and prepare them for use"
task :install do
    home = File.expand_path('~')

    Dir['*'].each do |file|
	next if file =~ /install/
	target = File.join(home, ".#{file}")
	`ln -s #{File.expand_path file} #{target}`
    end
end

task :default => 'install'