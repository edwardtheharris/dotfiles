---
title: User shell config
---

Scripts for customizing user shells.

## Requirements

- [BASH](https://www.gnu.org/software/bash/manual/bash.html)
- [Prompt Generator](https://bash-prompt-generator.org/)

## Role Variables

| Name    | Description                                                                 |
| ------- | --------------------------------------------------------------------------- |
| `user`  | Username for the user under operation                                       |
| `urole` | The type of user defined as one of these options [`sa`,`user`,`ns`, `root`] |

## Dependencies

- None

## Example Playbook

User shell configuration role example.

```{code-block} yaml
- name: Update user shell and settings
  hosts: servers
  roles:
    - role: user
      user: luser
      urole: user
```

## License

Copyright (c) Xander Harris 2025. All rights reserved.

## Author Information

```{sectionauthor} Xander Harris <xandertheharris@gmail.com>

```
