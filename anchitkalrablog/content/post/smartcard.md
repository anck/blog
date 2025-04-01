---
title: "Automating certificates for Smartcard Setup On XenDesktop"
date: 2015-10-20T11:49:55-08:00
Description: "Smartcard Setup On XenDesktop"
Tags: [scripting, automation, development]
Categories: [automation, development]
DisableComments: false
---
##### ref: https://bitbucket.org/anck/xdsmartcard/src

I needed to write a small script which copied the state of the certificate store on a Windows machine. While digging through my notes, I found this script. I had written this to automate setting up smart cards for Xen Desktop 5.6\7.x. The only other change after running this is the StoreFront SSL for Xen Desktop 7.x.

Although a very specific use case, there is a fair bit of code which can be used to automate other certificate related tasks. There are generic functions, which help sending a certificate request and then installing the certificate on a local machine.

There are two files, support_certificaterequest.ps1: This file contains functions which automate the process of requesting a certificate from the CA Server.
support_smartcard.ps1 :  Calls the certificaterequest.ps1 to request certificates from the domain's Certificate Authority and binds the certificate to the web interface.

The below code in certificaterequest.ps1, tries to find the default CA in the domain.

'''
$domain = ([System.DirectoryServices.ActiveDirectory.Domain]::GetCurrentDomain()).Name
$domain = "DC=" + $domain -replace '\.', ", DC="
write-verbose "Searching for CA in the domain"
$CA = [ADSI]"LDAP://CN=Enrollment Services, CN=Public Key Services, CN=Services, CN=Configuration, $domain"
'''

Above would fail if in case the CA is in a parent domain. Say, the machine's domain is mydomain.net(child) and the CA is in mydomainroot (parent). I sorta got lazy and hard coded the LDAP query specific to my case, you may want to edit those values out.

You may also wish to change the type of certificate being requested and installed on the Machine. To do this the request.inf file needs to be edited. I am storing the string in '$DCRequestINF' variable.

'''
$DCRequestINF =
@"
;----------------- request.inf -----------------</code>

[Version]

Signature="$Windows NT$

[NewRequest]
Subject="O=Citrix,CN=$fqdn,OU=LCM"
KeySpec = 1
KeyLength = 2048
Exportable = TRUE
MachineKeySet = TRUE
SMIME = FALSE
PrivateKeyArchive = FALSE
UserProtected = FALSE
UseExistingKeySet = FALSE
ProviderName = "Microsoft RSA SChannel Cryptographic Provider"
ProviderType = 12
RequestType = PKCS10
KeyUsage = 0xa0

[EnhancedKeyUsageExtension]

OID=1.3.6.1.5.5.7.3.1 ; this is for Server Authentication

[RequestAttributes]
;
;-----------------------------------------------
'''