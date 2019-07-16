#!/usr/bin/env bash

# YUM install
# step1: Download and install the public signing key
rpm --import https://artifacts.elastic.co/GPG-KEY-elasticsearch

# step2: Add the following in your /etc/yum.repos.d/ directory in a file with a .repo suffix, for example logstash.repo
cat > /etc/yum.repos.d/logstash.repo <<EOF
	[logstash-7.x]
	name=Elastic repository for 7.x packages
	baseurl=https://artifacts.elastic.co/packages/7.x/yum
	gpgcheck=1
	gpgkey=https://artifacts.elastic.co/GPG-KEY-elasticsearch
	enabled=1
	autorefresh=1
	type=rpm-md
EOF

# step3: And your repository is ready for use. You can install it with
yum install logstash
