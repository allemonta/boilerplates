mkdir secrets
cd secrets
rm -f sern_key.pem
rm -f sern_key.pem.pub
ssh-keygen -f sern_key.pem -N ""