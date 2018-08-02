**IMPORTANT: Please do not create a Pull Request without creating an issue first.**

*Any change needs to be discussed before proceeding. Failure to do so may result in the rejection of the pull request.*

Please provide enough information so that others can review your pull request:

Explain the **details** for making this change. What existing problem does the pull request solve?

**Test plan (required)**

Demonstrate the code is solid. Example: The exact commands you ran and their output, screenshots / videos if the pull request changes UI.

Write your test code using RSpec.

This gem requires a connection to a test Filebound server to run specs.  We expect all specs to pass when we run them against our local test Filebound server.  Travis CI won't run the specs because we don't have access to a Filebound server within the Travis servers but we need to be able to run the specs locally where we do have access to a Filebound test server.  It would be helpful if you let us know what version of the Filebound API you were using to run your specs against as well just in case there are compatibility issues.

**Code formatting**

Lint you code through Rubocop and fix any issues that come up before submitting the PR.

**Closing issues**

Put `closes #XXXX` in your comment to auto-close the issue that your PR fixes (if such).