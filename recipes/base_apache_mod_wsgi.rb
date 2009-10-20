wsgi_version = '2.6'

sh "svn co http://modwsgi.googlecode.com/svn/branches/mod_wsgi-#{wsgi_version} /usr/src/mod_wsgi-#{wsgi_version}"
cd "/usr/src/mod_wsgi-#{wsgi_version}" do
  sh './configure'
  sh 'make'
  sh 'make install'
end