---
abstract: Installation and configuration of `dex`.
authors: Xander Harris
date: 2024-02-06
title: dex
---

## Purpose

This is required to allow the `kube-apiserver` to authenticate
against an existing Samba Active Directory Domain Controller.

The Ansible playbook in this directory does the following.

1. Install `dex`.
2. Configure `dex` for use with an existing AD DC.
3. Prepare `dex` for availaibility to the `kube-apiserver`.
4. Start the `dex` service.
5. Enable the `dex` service.

## Notes

> Once you have Dex configured and running, you'll need to configure the
> Kubernetes API server to use Dex for authentication. This involves
> setting up the OIDC flags on the kube-apiserver, such as
> `--oidc-issuer-url`, `--oidc-client-id`, `--oidc-username-claim`, etc.,
> to point to your Dex deployment.
>
> Remember, deploying Dex and configuring it correctly requires careful
> consideration of your network setup, security policies, and the
> specifics of your Samba AD deployment. The above configuration is a
> starting point and will likely need adjustments to fit your
> environment securely and correctly.
>
> -- ChatGPT4
