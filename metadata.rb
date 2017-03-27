name             'didata-fabio'
maintainer       'Alex Bacchin'
maintainer_email 'alex.bacchin@dimensiondata.com'
license          'Apache 2.0'
description      'Installs and configures fabio (zero-conf load balancing HTTP router for deploying microservices managed by consul)'
version          '1.2.5'

supports 'centos'
supports 'redhat'

depends 'poise-service'
depends 'apt'
depends 'yum'
depends 'firewall', '~> 2.5.2'
depe