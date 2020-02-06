# to be run on windows with powershell
echo Importing Root certificate to Trusted Root Certification Authorities
Import-Certificate -FilePath "target/CTILocalHostRoot.crt" -CertStoreLocation Cert:\LocalMachine\Root ;

echo Importing Personal Certificate 
Import-Certificate -FilePath "target/CTILocalhost.pfx" -CertStoreLocation 'Cert:\CurrentUser\My' ;
