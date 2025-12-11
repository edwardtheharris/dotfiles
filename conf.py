# pylint: disable=invalid-name,redefined-builtin
"""
Configuration file for the Sphinx documentation builder.

For the full list of built-in configuration values, see the documentation:
https://www.sphinx-doc.org/en/master/usage/configuration.html

-- Project information -----------------------------------------------------
https://www.sphinx-doc.org/en/master/usage/configuration.html#project-information

-- General configuration ---------------------------------------------------
https://www.sphinx-doc.org/en/master/usage/configuration.html#general-configuration
"""
import sys
from pathlib import Path

sys.path.append(str(Path("roles/dev/files").resolve()))
sys.path.append(str(Path("roles/dev/files/githooks").resolve()))

author = "Xander Harris"
autoyaml_root = "."
copyright = "2024, Xander Harris"
exclude_patterns = [
    "_build",
    "Thumbs.db",
    ".DS_Store",
    ".pytest_cache/*",
    ".tox/*",
    ".venv/*",
]
extensions = [
    "myst_parser",
    "sphinx_copybutton",
    "sphinx_design",
    "sphinx_last_updated_by_git",
    "sphinx_git",
    "sphinx.ext.autodoc",
    "sphinx.ext.coverage",
    "sphinx.ext.duration",
    "sphinx.ext.githubpages",
    "sphinx.ext.graphviz",
    "sphinx.ext.todo",
    "sphinxcontrib.autoyaml",
]
git_untracked_check_dependencies = False
graphviz_output_format = "png"
# -- Options for HTML output -------------------------------------------------
# https://www.sphinx-doc.org/en/master/usage/configuration.html#options-for-html-output
html_context = {"full_path": str(Path(".").resolve())}
html_favicon = "_static/img/logo/xander-harris.png"
html_logo = "_static/img/logo/xander-harris.png"
html_static_path = ["_static"]
html_theme = "sphinx_book_theme"
html_theme_options = {
    "home_page_in_toc": True,
    "icon_links": [
        {
            # Label for this link
            "name": "GitHub",
            # URL where the link will redirect
            "url": "https://github.com/edwardtheharris/dotfiles",  # required
            # Icon class (if "type": "fontawesome"), or path to local image (if "type": "local")
            "icon": "fa-brands fa-square-github",
            # The type of image to be used (see below for details)
            "type": "fontawesome",
        },
        {
            # Label for this link
            "name": "HackerRank",
            # URL where the link will redirect
            "url": "https://www.hackerrank.com/profile/xandertheharris",
            # Icon class (if "type": "fontawesome"), or path to local image (if "type": "local")
            "icon": "fa-brands fa-hackerrank",
            # The type of image to be used (see below for details)
            "type": "fontawesome",
        },
        {
            # Label for this link
            "name": "LinkedIn",
            # URL where the link will redirect
            "url": "https://linkedin.com/xandertheharris",  # required
            # Icon class (if "type": "fontawesome"), or path to local image (if "type": "local")
            "icon": "fa-brands fa-linkedin",
            # The type of image to be used (see below for details)
            "type": "fontawesome",
        },
    ],
}
myst_enable_extensions = [
    "amsmath",
    "attrs_block",
    "attrs_inline",
    "colon_fence",
    "deflist",
    "dollarmath",
    "fieldlist",
    "html_admonition",
    "html_image",
    "linkify",
    "replacements",
    "smartquotes",
    "strikethrough",
    "substitution",
    "tasklist",
]
myst_footnote_transition = True
myst_title_to_header = True
project = "Xander's Dot Files and Sundry Store"
with Path(".version").open("r", encoding="utf-8") as r_fh:
    release = r_fh.read()
show_authors = True
source_suffix = {
    ".md": "markdown",
}
templates_path = ["_templates"]
