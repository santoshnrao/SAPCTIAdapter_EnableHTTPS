# #Clean up CTILocalhost output folder
if [ -d "target" ]; then
  # Control will enter here if $DIRECTORY exists.
  echo clean up target directory
  rm -r target;
fi

echo Create new folder
mkdir target ;

echo folder chaing 
cd target ;

echo Generating RootKey
openssl req -x509 -nodes -new -sha256 -days 1024 -newkey rsa:2048 -keyout CTILocalHostRoot.key -out CTILocalHostRoot.pem -subj "/C=US/CN=localhost";

echo Generating root cert
openssl x509 -outform pem -in CTILocalHostRoot.pem -out CTILocalHostRoot.crt ;

echo Generating localhost cert and key 
openssl req -new -nodes -newkey rsa:2048 -keyout CTIAdapterLocal.key -out CTIAdapterLocal.crs -subj "/C=US/ST=CA/L=Palo Alto/O=CTI Openssl Cert/CN=localhost";

echo Generating cert with domains 
openssl x509 -req -sha256 -days 1024 -in CTIAdapterLocal.crs -CA CTILocalHostRoot.pem -CAkey CTILocalHostRoot.key -CAcreateserial -extfile ./../domains.ext -out CTILocalhost.crt ;

echo Exporting certificate with key - requests password

openssl pkcs12 -export  -out CTILocalhost.pfx -inkey CTIAdapterLocal.key -in CTILocalhost.crt ;

echo fingerprint of the certificate
openssl x509 -in CTILocalhost.crt -noout -fingerprint;

