HOST=$1
echo "host: $HOST"
ssh -i ~/.ssh/jasonci.pem -o StrictHostKeychecking=no ec2-user@$HOST 'bash -s' < ./scripts/setup_steps.sh
