#!/usr/bin/env python3
"""
A small Python script to produce commit messages.

.. rubric:: Prepare Commit Message

This hook is invoked by `git-commit[1] <https://git-scm.com/docs/git-commit>`_
right after preparing the default log message, and before the editor is started.

It takes one to three parameters. The first is the name of the file that
contains the commit log message. The second is the source of the commit message,
and can be: message (if a ``-m`` or ``-F`` option was given); template
(if a ``-t`` option
was given or the configuration option ``commit.template`` is set);
merge (if the commit is a merge or a :file:`.git/MERGE_MSG` file exists);
squash (if a :file:`.git/SQUASH_MSG` file exists); or commit, followed by a
commit object name (if a ``-c``, ``-C`` or ``--amend`` option was given).

If the exit status is non-zero, ``git commit`` will abort.

The purpose of the hook is to edit the message file in place, and it is not
suppressed by the ``--no-verify`` option. A non-zero exit means a failure of the
hook and aborts the commit. It should not be used as a replacement for the
pre-commit hook.

The sample :file:`prepare-commit-msg` hook that comes with Git removes the help
message found in the commented portion of the commit template.
"""
import re

from pathlib import Path

import git
from git import Repo
from loguru import logger


def get_git_branch() -> str:
    """Return the currently checked out branch.

    :var str ret_value: Value to be returned, or the branch of the current
        commit decoded and stripped of whitespace.
    :return ret_value: The branch of the current commit.
    """
    logger.info(__name__)
    git_r = git.Repo(Path("."))
    try:
        return_value = str(git_r.active_branch.name)
    except TypeError:
        return_value = "rebase"
    return return_value


def get_git_username() -> int | float | str:
    """Return the value of the git username from the configuration."""
    git_config = git.Repo(Path(".")).config_reader()
    username = git_config.get_value("user", "username")
    return username


def get_issue_number(branch: str) -> str | TypeError:
    """Return the issue number based on the branch name.

    :param str branch: Branch we can extract an issue from
    """
    issue_number = str()
    try:
        in_match = re.search(r"^(\d+)", branch)
        issue_number = in_match[1]
    except TypeError as type_err:
        issue_number = type_err
    return issue_number


def get_issue_message(branch: str) -> str | TypeError:
    """Return the issue number based on the branch name.

    :param str branch: Branch we can extract an issue from
    """
    issue_message = str()
    msg_match = re.search(r"^\d+-(.*)", branch)
    try:
        issue_message = msg_match[1].replace("-", " ")
    except TypeError as type_err:
        issue_message = type_err
    return issue_message


def get_jira_ticket(branch: str) -> str | TypeError:
    """Return the issue number based on the branch name.

    :param str branch: Branch we can extract an issue from
    """
    jira_ticket = str()
    try:
        jira_match = re.search(r"^.*\-([a-z]+-\d+)-.*", branch)
        jira_ticket = jira_match[1].upper()
    except TypeError as type_err:
        jira_ticket = type_err
    return jira_ticket


def parse_branch_name(branch: str) -> dict:
    """Use regex to pull the issue number from the branch name.

    :param str branch: A git branch containing an issue or jira_ticket
        example: `46-inf-197-add-docs-for-updated-files`
    """
    ret_value = {
        "issue_number": get_issue_number(branch),
        "issue_message": get_issue_message(branch),
        "jira_ticket": get_jira_ticket(branch),
    }
    return ret_value


def prepare_message(branch_name: str, parsed_branch: dict, git_username: str):
    """Prepare a commit message."""
    if branch_name != "main":
        issue_msg = parsed_branch.get("issue_message")
        issue_num = parsed_branch.get("issue_number")
        jira_ticket = parsed_branch.get("jira_ticket")
        config_read = Repo(Path(".")).config_reader()
        user_email = config_read.get_value("user", "email")
        user_name = config_read.get_value("user", "name")
        ret_value = (
            f"{issue_msg}\n\n"
            f"Closes #{issue_num}\n\n"
            f"{jira_ticket}\n\n"
            f"Jira: {jira_ticket}\n"
            f"User: @{git_username}\n"
            f"Author: '{user_name} <{user_email}>'\n"
            "Changelog: changed"
        )
    else:
        ret_value = (
            "Initial commit\n\n"
            "Changelog: created\n\n"
            "Author: '{user_name} <{user_email}>'"
        )
    return ret_value


def write_message():
    """Write the prepared commit message."""
    logger.info(__name__)
    branch = get_git_branch()
    parsed_branch = parse_branch_name(branch)
    git_username = get_git_username()
    commit_msg = prepare_message(branch, parsed_branch, git_username)
    msg_file = Path(".git/COMMIT_EDITMSG")
    if msg_file.exists():
        with msg_file.open("a", encoding="utf-8") as msg_fh:
            msg_fh.write(commit_msg)
    return commit_msg


if __name__ == "__main__":
    write_message()
