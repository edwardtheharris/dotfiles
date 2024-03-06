"""Test module for the prepare commit msg file."""
import os

from unittest.mock import patch

from .prepare_commit_msg import (
    get_git_branch,
    get_git_username,
    parse_branch_name,
    prepare_message,
    write_message,
)

@patch('subprocess.run')
def test_get_git_branch(mock_subprocess_run):
    """Verify returnable git branch.

    :param mock_subprocess_run: Mock results of a subprocess run.
    """
    mock_subprocess_run.return_value.stdout.decode.return_value = 'feature-123'
    assert get_git_branch() == 'feature-123'
    mock_subprocess_run.assert_called_once_with(
        'git branch --show-current',
        check=False,
        capture_output=True,
        shell=False,
        executable="/bin/bash"
    )

@patch('subprocess.run')
def test_get_git_username(mock_subprocess_run):
    """Verify that we can fetch the git username.

    :param mock_subprocess_run: Mock results of a subprocess run.
    """
    mock_subprocess_run.return_value.stdout.decode.return_value = 'your_username'
    assert get_git_username() == 'your_username'
    mock_subprocess_run.assert_called_once_with(
        'git config --get user.username',
        check=False,
        shell=False,
        capture_output=True,
        executable='/bin/bash'
    )

def test_parse_branch_name():
    """Test feature branch parse."""
    branch_name = '123-feature-branch'
    result = parse_branch_name(branch_name)
    assert result == {'issue_number': '123', 'issue_message': 'feature branch'}

def test_prepare_message_main_branch():
    """Handle a main branch."""
    with patch('your_script_file.get_git_branch', return_value='main'), \
         patch('your_script_file.get_git_username', return_value='your_username'), \
         patch.dict(os.environ, {'GIT_AUTHOR_EMAIL': 'your_email', 'GIT_AUTHOR_NAME': 'your_name'}):
        result = prepare_message()
    assert 'Hey @your_username!' in result
    assert 'Changelog: kitten killer' in result

def test_prepare_message_feature_branch():
    """Create message for a feature branch."""
    with patch('your_script_file.get_git_branch', return_value='feature-123'), \
         patch('your_script_file.get_git_username', return_value='your_username'), \
         patch.dict(os.environ, {'GIT_AUTHOR_EMAIL': 'your_email', 'GIT_AUTHOR_NAME': 'your_name'}):
        result = prepare_message()
    assert 'See #123' in result
    assert '@your_username' in result
    assert 'Changelog: changed' in result

@patch('builtins.open', create=True)
def test_write_message(mock_open):
    """Verify commit message file write."""
    mock_file = mock_open.return_value.__enter__.return_value
    mock_file.exists.return_value = True
    write_message()
    mock_file.write.assert_called_once_with(prepare_message())

# Add more tests as needed
