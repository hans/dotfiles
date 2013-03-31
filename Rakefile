require 'rake'

# from http://errtheblog.com/posts/89-huba-huba
# rakefile-ized by Hans Engel (http://engel.uk.to)

desc "Copy dotfiles into the current user's home directory and prepare them for use"
task :install do
    home = '~'
    home_expanded = File.expand_path home

    Dir['*'].each do |file|
	next if file =~ /install/ or file == 'Rakefile' or file =~ /\/.m(ark)?d(own)?$/i
	target = File.join home, ".#{file}"

        source = File.expand_path file
        source = source.gsub(home_expanded + '/', '')

	puts "#{source} -> #{target}"
	`ln -s #{source} #{target}` unless File.exists?(target)
    end
end

task :default => 'install'
