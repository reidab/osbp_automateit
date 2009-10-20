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
    begin
      original_path = ENV['PATH']
      ENV['PATH'] = "#{File.join(pwd,env,'bin')}:#{ENV['PATH']}"
      block.call
    ensure
      ENV['PATH'] = original_path
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