# ArchLinux basic setup

Add some missing packages and configure a thing or two.

## Requirements

Package installation is handled with [yay-bin](https://aur.archlinux.org/yay-bin).

## Role Variables

| variable | description                   | default |
| -------- | ----------------------------- | ------- |
| packages | A list of packages to install | []      |

## Dependencies

None

## Example Playbook

```{code-block} yaml
    - hosts: servers
      roles:
         - role: arch
           vars:
              packages:
                - plasma
```

## License

BSD

## Author Information

```{sectionauthor} Xander Harris <xandertheharris@gmail.com>

```
