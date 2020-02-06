# Steps to enabled CTI Adapter in https mode

# prerequisite softwares

- openssl
- netsh
- admin rights for windows

# Create Self signed certificate
```openssl req -x509 -nodes -new -sha256 -days 1024 -newkey rsa:2048 -keyout RootCA.key -out RootCA.pem -subj "/C=US/CN=localhost"```

```openssl x509 -outform pem -in RootCA.pem -out RootCA.crt```

```openssl req -new -nodes -newkey rsa:2048 -keyout localhost.key -out localhost.csr -subj "/C=US/ST=CA/L=Palo Alto/O=CTI Openssl Cert/CN=localhost"```

## Uses domains.ext file to provide additional extensions for certificate 
```openssl x509 -req -sha256 -days 1024 -in localhost.csr -CA RootCA.pem -CAkey RootCA.key -CAcreateserial -extfile domains.ext -out localhost.crt```

## netsh requires a certificate exported with private key
```openssl pkcs12 -export -out certificate.pfx -inkey localhost.key -in localhost.crt```

## display fingerprint
```openssl x509 -in localhost.crt -noout -fingerprint```

# Import certificate to personal store using mmc

- open mmc application
- File new "Add/Remove snap id"
- Choose Certificates
- Choose "computer account"
- Import **certificate.pfx** file generated in Step1 to "Personal"  -> "Certificate"
- Import **Root.crt"** file generated in step1 to "Trusted Root Certification Authoritise" -> "Certificates"

## Copy Thumbprint
- Open the imported certificate, under details section copy the Thumbprint

# Bind certificate to port 
```Run the cmd promt in administration mode```
## Check if there are certificates
```netsh http show sslcert ipport=0.0.0.0:36731```
## Delete if any certificates are alerady associated 
```netsh http delete sslcert ipport=0.0.0.0:36731```

## Bind certificate
```netsh http add sslcert ipport=0.0.0.0:36731 certhash=`thumbprintFromPreviousStep` appid={7e46cd40-39c6-4813-b414-019ad22e55b2}```

# Run Adapter in 
- Open SAP CTI Adapter 
- Launch a browser window and open ulr https://localhost:36731/CTIMain.htm

<!-- https://gist.github.com/cecilemuller/9492b848eb8fe46d462abeb26656c4f8 -->
