# apprtc_docker


docker build -t apprtc .

docker run -p 8080:8080 -it apprtc


#create cert
openssl genrsa -des3 -out collider.key 2048
openssl req -new -key collider.key -out collider.csr
cp collider.key collider.key.org
openssl rsa -in collider.key.org -out collider.key
openssl x509 -req -days 365 -in collider.csr -signkey collider.key -out collider.crt


