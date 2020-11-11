cd secrets
echo -------------------------------------------------------------------------- > secrets.txt
echo >> secrets.txt
echo EC2 host: $1 >> secrets.txt 
echo EC2 connection: ssh -i secrets/$2.pem ec2-user@$1 >> secrets.txt
echo API documentation: http://$1/api-docs >> secrets.txt 
echo >> secrets.txt
echo -------------------------------------------------------------------------- >> secrets.txt
echo >> secrets.txt
echo JWT secret = $3 >> secrets.txt
echo >> secrets.txt
echo -------------------------------------------------------------------------- >> secrets.txt 