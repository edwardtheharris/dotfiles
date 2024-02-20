---
abstract: To the extend dotfiles need a security policy, this is it.
authors: Xander Harris
date: 2024-02-19
title: Security Policy
---

## Automation

Find and use all of the automated security checks that are relevant and
available to an open source repository.

### Bandit

Not much Python in here, but it's worth scanning anyway.

```{autoyaml} .github/workflows/bandit.yml
```

### Scorecard

FOSS is great when you're broke.

```{autoyaml} .github/workflows/scorecard.yml
```

## Reporting a Vulnerability

No one should be using the code in this repository for anything, but if you
are for some reason doing so and you notice a problem, please create an
issue [here](https://github.com/edwardtheharris/dotfiles/issues).
