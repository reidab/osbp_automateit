modified = false

wsgi_version = '2.6'
tag = "mod_wsgi-#{wsgi_version}"


unless File.exist?('/usr/lib/apache2/modules/mod_wsgi.so')
  mktempdircd do
    sh "svn co http://modwsgi.googlecode.com/svn/tags/#{tag} #{tag}"
    cd tag do
      sh './configure'
      sh 'make'
      sh 'make install'
      modified = true
    end
  end
end

modified |= render :text => <<-HERE, :to => "/etc/apache2/mods-available/mod_wsgi.load"
LoadModule wsgi_module modules/mod_wsgi.so
HERE

modified |= apache_manager.enable_module "mod_wsgi
apache_manager.reload if modified"

