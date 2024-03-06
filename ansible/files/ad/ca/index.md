---
abstract: Create a self-signed certificate authority for use with your AD DC.
authors: Xander Harris
date: 2024-02-29
title: ArchLinux AD DC self-signed  CA
---

## Root CA

From the primary DC, follow these steps to create the root CA.

1. Open a root console.
2. Change the working directory to {file}`/etc/ssl`.
3. Create the private key.

    ```{code-block} shell
    :caption: create /etc/ssl/private/ca.key

    openssl genpkey -algorithm RSA -out private/ca.key
    ```

4. Create the certificate.

    ```{code-block} shell
    :caption: create /etc/ssl/certs/ca.crt

    openssl req -new -x509 -key private/ca.key -out certs/ca.crt
    ```

5. Update the {file}`smb.conf`

    ```{code-block} ini
    :caption: /etc/samba/smb.conf

    tls enabled  = yes
    tls keyfile  = /etc/ssl/private/ca.key
    tls certfile = /etc/ssl/certs/ca.crt
    tls cafile   = /etc/ssl/certs/ca.crt
    ```

6. Restart Samba.

    ```{code-block} shell
    systemctl restart samba
    ```

7. Update the CA trust store.

    ```{code-block} shell
    update-ca-trust
    trust anchor --store /etc/ssl/certs/ca.crt
    ```

## Intermediate CA

From the primary DC, follow these steps to add the intermediate CA.

1. Open a root console.
2. Change the working directory to {file}`/etc/samba/`.

    ```{code-block} shell
    cd /etc/samba
    ```

3. Create a {file}`pki` directory.

    ```{code-block} shell
    mkdir /etc/samba/pki
    ```

4. Create the intermediate private key.

    ```{code-block} shell
    :caption: create /etc/samba/private/int.key

    openssl genpkey -algorithm RSA -out private/int.key
    ```

5. Create the intermediate CSR.

    ```{code-block} shell
    :caption: create /etc/samba/pki/int.csr

    openssl req -new -key private/int.key -out pki/int.csr
    ```

6. Create the intermediate CA.

    ```{code-block} shell
    :caption: create /etc/samba/pki/int.crt

    openssl x509 -req -in pki/int.csr -CA /etc/ssl/certs/ca.crt -CAkey /etc/ssl/private/ca.key -out pki/int.crt
    ```

7. Update the {file}`smb.conf`.

    ```{code-block} ini
    :caption: /etc/samba/smb.conf

    tls enabled  = yes
    tls keyfile  = /etc/samba/private/int.key
    tls certfile = /etc/samba/pki/int.crt
    tls cafile   = /etc/ssl/certs/ca.crt
    ```

8. Restart Samba.

    ```{code-block} shell
    systemctl restart samba
    ```

9. Update the CA trust store.

    ```{code-block} shell
    update-ca-trust
    trust anchor --store /etc/samba/pki/int.crt
    ```

If you have a secondary DC, follow the Intermediate CA steps there after
you copy the Root CA files over.

```{code-block} shell
:caption: Create an Intermediate CA

openssl req -new -key private/dc01.int.key -out csr/dc01.int.csr -config ca.cnf
openssl x509 -req -in csr/dc01.int.csr -CA /etc/ssl/certs/ca.crt \
    -CAkey /etc/ssl/private/ca.key -CAcreateserial -out certs/dc01.int.crt \
    -days 36500 -extensions SAN -extfile san.cnf
```
