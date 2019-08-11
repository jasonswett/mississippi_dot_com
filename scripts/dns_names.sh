aws ec2 describe-instances \
	--profile personal \
	--query 'Reservations[].Instances[].PublicDnsName'

#	--filters Name=tag:suite-magic-ready,Values=true \
