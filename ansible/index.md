---
abstract: Ansible configuration and usage.
authors:
  - name: Xander Harris
    email: xandertheharris@gmail.com
title: Ansible
---

```{toctree}
:caption: roles

roles/k8s/files/controller-manager/index
roles/k8s/files/apiserver/index
roles/root/index
roles/k8s/index
roles/index
```

## Playbooks

The playbook and associated roles are check with
[ansible-lint](https://ansible.readthedocs.io/projects/lint/) according
to the rules set in {file}`.ansible-lint`[^ansible-lint].

### Inventory

This is an example hosts file and is not used anywhere. To use this do the
following.

1. Create a group named `ansible`.

   ```{code-block} shell
   groupadd ansible
   ```

2. Create a directory named {file}`/etc/ansible`.

   ```{code-block} shell
   sudo mkdir -pv /etc/ansible
   ```

3. Change the ownership of that directory to the `ansible` group.

   ```{code-block} shell
   sudo chgrp ansible /etc/ansible
   ```

4. Make the directory group writable.

   ```{code-block} shell
   sudo chmod g+w /etc/ansible
   ```

5. Add your user to the `ansible` group and relaunch your shell.

   ```{code-block} shell
   sudo usermod -a -G ansible $USER
   /bin/bash || exit
   ```

6. Copy this example hosts file to {file}`/etc/ansible/hosts.yml` and edit it.

   ```{code-block} shell
   cp hosts.yml /etc/ansible/hosts.yml
   vi /etc/ansible/hosts.yml
   ```

#### {file}`hosts.yml`

```{autoyaml} ansible/hosts.yml

```

```{sectionauthor} Xander Harris <xander.harris@gmail.com>

```

[^ansible-lint]:
    More information on configuring
    [ansible-lint](https://ansible.readthedocs.io/projects/lint/) can be found
    in the related
    [docs](https://ansible.readthedocs.io/projects/lint/configuring/#ansible-lint-configuration).
