# Contributing to the Filebound Client Gem

Thank you for taking the time to contribute to this project!  We gladly welcome new suggestions and pull requests!

This document details the guidelines around contributing to this gem.  If anything is vague or unclear let us know or
submit a pull request with your suggested changes!  Again these are guidelines and not hard and fast rules so please use
your discretion.

## Code of Conduct

You can access our code of conduct [here](./CODE_OF_CONDUCT.md).  It is based on the 
[Contributor Covenant](https://www.contributor-covenant.org/) Code of Conduct.  Please report conduct that violates
this code to [dev@heiskell.com](mailto:dev@heiskell.com).

## Contributing

### Reporting Bugs

Thank you for reporting those pesky bugs!

In order for us to effectively reproduce and therefore fix the bug we need a "good" bug report submitted by you.
All bug reports can be submitted by going to the Issues tab in GitHub and clicking "New Issue".

#### Submitting A Good Bug Report

So what is meant by a good bug report?  Well first of all please use GitHub's built in issue tracking by going to 
the issues tab and clicking "New Issue".  Then please use [this document](.github/ISSUE_TEMPLATE/bug_report.md) as the template for submitting the report.
Following this template should hopefully give us enough information to reproduce and fix the issue you have discovered.
Thank you!

### Suggesting Enhancements

We always welcome enhancement suggestions!  Making this software better is a high priority so thank you for any suggestions you may have!  Given that we do have some guidelines to follow when making enhancement suggestions.

#### Submitting a Good Enhancement Suggestion

Submitting a good enhancement suggestion is key to making this software do what it is intended to do with minimal technical debt and to properly test the functionality.  

Enhancement suggestions can be submitted through GitHub using the built-in issue tracking.  All issues opened for enhancements should be tagged as such to differentiate them from bug reports.  Please use [this document](.github/ISSUE_TEMPLATE/feature_request.md) as the template for submitting an enhancement suggestion.

### Pull Requests

If you would like to contribute to the project, great! Thank you for taking the time to work on this project! Given that it is important to let us know some information about the code and what feature or problem you are submitting the request for.  Please use [this document](.github/PULL_REQUEST_TEMPLATE.md) as a template for submitting your PR and again, thank you!

## Styleguides

Please follow these style guides when submitting code to this project.  It helps for readability and productivity if everyone is on the same page with how code and commits are supposed to be formatted.

### Commit Messages

We use this git commit style guide suggested by Tim Pope - https://tbaggery.com/2008/04/19/a-note-about-git-commit-messages.html

```
Capitalized, short (50 chars or less) summary

More detailed explanatory text, if necessary.  Wrap it to about 72
characters or so.  In some contexts, the first line is treated as the
subject of an email and the rest of the text as the body.  The blank
line separating the summary from the body is critical (unless you omit
the body entirely); tools like rebase can get confused if you run the
two together.

Write your commit message in the imperative: "Fix bug" and not "Fixed bug"
or "Fixes bug."  This convention matches up with commit messages generated
by commands like git merge and git revert.

Further paragraphs come after blank lines.

- Bullet points are okay, too

- Typically a hyphen or asterisk is used for the bullet, followed by a
  single space, with blank lines in between, but conventions vary here

- Use a hanging indent
```

### Ruby Styleguide

Please lint all code through Rubocop using the .rubocop.yml file in the root of this repository before submitting a PR.

### Specs Styleguide

Please lint your spec code through Rubocop using .rubocop.yml as well.

### Documentation Styleguide

We use YARD for document generation so please use the conventions stated at https://yardoc.org.  Make sure all public interfaces are documented and parameters and return values are in that documentation.



