---
title: User shell config
---

Scripts for customizing user shells.

## Requirements

- [BASH](https://www.gnu.org/software/bash/manual/bash.html)
- [Prompt Generator](https://bash-prompt-generator.org/)

## Role Variables

| Name    |Type| Description                                                                 |
| ------- | ---|------------------------------------------------------------------------ |
| `user`  | string|Username for the user under operation                                       |
| `useremail`| string| User's email|
|`usergroup`| string|User's primary group|
|`userhome`| string|User's home directory|
|`username`| string|User's name|
|`userrole`| string|Type of user being setup|
|`systemos`| string| OS/Distro the user is running|

## Dependencies

```{toctree}
files/ubuntu/index

```

## Example Playbook

Usage example follows.

```{code-block} yaml
- name: Update user shell and settings
  hosts: servers
  roles:
    - role: user
      tags:
        - user
      vars:
        user: named
        useremail: string
        usergroup: string
        userhome: string
        username: string
        userrole: string
        systemos: string
```

## License

[Unlicense](https://unlicense.org)

## Author Information

```{sectionauthor} Xander Harris <xandertheharris@gmail.com>

```
