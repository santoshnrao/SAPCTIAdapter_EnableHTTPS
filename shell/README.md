# Shell executable to generate certificate and import the certificate to root in Windows

## Prerequisite to have the following installers

- Powershell
- openssl
- import-Certificate
- netsh [ Admin rights]

# Running

Open the powershell console

## Generating the certificate

```./createCert.sh```

This would create a target folder in the system. 

## Import certificates

```importCertificate.sh```


## Bind certificate to https port

open **cmd** in administrative mode

```netsh http add sslcert ipport=0.0.0.0:36731 certhash=`thumbprintFromPreviousStep` appid={7e46cd40-39c6-4813-b414-019ad22e55b2}```
