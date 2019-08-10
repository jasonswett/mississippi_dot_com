aws ec2 describe-instances \
	--profile personal \
	--filters Name=tag:suite-magic-ready,Values=true \
	--query 'Reservations[].Instances[].PublicDnsName'
