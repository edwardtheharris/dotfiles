"""Test module for the prepare commit msg file."""

import re

from pathlib import Path

from git import Repo
from loguru import logger

from .prepare_commit_msg import (
    get_git_branch,
    get_git_username,
    get_issue_message,
    get_issue_number,
    get_jira_ticket,
    prepare_message,
    write_message,
)


def test_get_git_branch():
    """Verify returnable git branch.

    :param mock_subprocess_run: Mock results of a subprocess run.
    """
    logger.debug(__name__)
    test_branch = Repo(Path(".")).active_branch.name

    assert get_git_branch() == test_branch


def test_get_git_username():
    """Verify that we can fetch the git username.

    :param mock_subprocess_run: Mock results of a subprocess run.
    """
    logger.debug(__name__)
    test_conf = Repo(Path(".")).config_reader()
    test_user = test_conf.get_value("user", "username")
    assert get_git_username() == test_user


def test_get_issue_message():
    """Test feature branch parse."""
    logger.debug(__name__)
    branch_name = Repo(Path(".")).active_branch.name
    msg_match = re.search(r"^\d+-(.*)", branch_name)
    issue_message = msg_match[1].replace("-", " ")
    assert issue_message == get_issue_message(branch_name)


def test_get_issue_number():
    logger.debug(__name__)
    branch_name = Repo(Path(".")).active_branch.name
    iss_match = re.match(r"^(\d*)(.*)", branch_name)
    assert iss_match[1] == get_issue_number(branch_name)


def test_get_jira_ticket():
    logger.debug(__name__)
    branch_name = "123-bbs-111-some-branch-name"
    jira_match = re.search(r"^.*\-([a-z]+-\d+)-.*", branch_name)
    jira_ticket = jira_match[1].upper()
    assert jira_ticket == get_jira_ticket(branch_name)


def test_prepare_message_main_branch():
    """Handle a main branch."""
    logger.debug(__name__)
    test_username = "edwardtheharris"
    test_res = prepare_message(
        "main", {"issue_number": "1", "issue_message": "none"}, test_username
    )
    assert f"Hey @{test_username}!" in test_res
    assert "Changelog: kitten killer" in test_res


def test_prepare_message_feature_branch():
    """Create message for a feature branch."""
    logger.debug(__name__)
    test_username = "edwardtheharris"
    test_branch = "123-feature-branch-test"
    result = prepare_message(
        test_branch,
        {"issue_message": "feature branch test", "issue_number": "123"},
        test_username,
    )
    assert "Closes #123" in result
    assert f"@{test_username}" in result
    assert "Changelog: changed" in result


def test_write_message():
    """Verify commit message file write."""
    logger.debug(__name__)
    with Path(".git/COMMIT_EDITMSG").open("w", encoding="utf-8") as c_fh:
        c_fh.write("")
        commit_msg = write_message()
        git_username = get_git_username()
    assert git_username in commit_msg
