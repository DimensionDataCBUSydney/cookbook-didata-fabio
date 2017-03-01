name             'didata-fabio'
maintainer       'Alex Bacchin'
maintainer_email 'alex.bacchin@dimensiondata.com'
license          'Apache 2.0'
description      'Installs and configures fabio (zero-conf load balancing HTTP router for deploying microservices managed by consul)'
version          '1.2.2'

supports 'ubuntu'
supports 'debian'
supports 'centos'

depends 'poise-service-runit'
depends 'apt'
depends 'yum'
