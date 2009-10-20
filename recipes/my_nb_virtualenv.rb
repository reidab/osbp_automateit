def virtualenv(env, opts = {}, &block)
  opts = {:site_packages => true}.merge(opts)
  
  args = []
  args << '-p #{opts[:python]}' if opts[:python]
  args << '--unzip-setuptools' if opts[:unzip_setuptools]
  
  args << '--no-site-packages' unless opts[:site_packages]
  args << '--clear' if opts[:clear]
  args << '--relocatable' if opts[:make_relocatable] # acts on existing virtualenv
  
  sh "virtualenv #{args.join(' ')} #{env}" if opts[:clear] || opts[:make_relocatable] || !File.exist?(env)
  
  if block_given?
    cd env do
      sh "source bin/activate"
      ENV['PATH'] = `echo $PATH`
      block.call
      sh "deactivate"
      ENV['PATH'] = `echo $PATH`
    end
  end
end

nb_root = "/var/www/northbay"

cd "/var/www/northbay" do
  virtualenv('nb_env', :site_packages => false) do
    package_manager.install <<-HERE, :with => :egg
      django
    HERE
  end
end