"""Test module for the prepare commit msg file."""

import re

from pathlib import Path

from git import Repo
from loguru import logger

from .prepare_commit_msg import (
    get_git_branch,
    get_git_username,
    parse_branch_name,
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


def test_parse_branch_name():
    """Test feature branch parse."""
    logger.debug(__name__)
    branch_name = Repo(Path(".")).active_branch.name
    regex_match = re.match(r"^(\d*)(.*)", branch_name)
    logger.info(regex_match)
    result = parse_branch_name(branch_name)
    test_issue_number = regex_match.groups()[0]
    test_issue_message = regex_match.groups()[1].replace("-", " ").lstrip()
    test_ret_value = {
        "issue_number": test_issue_number,
        "issue_message": test_issue_message,
    }
    assert result == test_ret_value


def test_prepare_message_main_branch():
    """Handle a main branch."""
    logger.debug(__name__)
    test_username = get_git_username()
    test_res = prepare_message(
        "main", {"issue_number": "1", "issue_message": "none"}, test_username
    )
    assert f"Hey @{test_username}!" in test_res
    assert "Changelog: kitten killer" in test_res


def test_prepare_message_feature_branch():
    """Create message for a feature branch."""
    logger.debug(__name__)
    test_username = get_git_username()
    test_branch = "123-feature-branch-test"
    result = prepare_message(
        test_branch,
        {"issue_message": "feature branch test", "issue_number": "123"},
        test_username,
    )
    assert "See #123" in result
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
