Releasing

- When https://github.com/overmindtech/cli is built and released. [Renovate](https://github.com/overmindtech/homebrew-overmind/issues/2) will automatically run and create a pull request. (or you can force it to run)
- EG this one `https://github.com/overmindtech/homebrew-overmind/pull/91`
- Once all the automated tests pass, add a label with pr-pull. This will trigger another automated workflow that pulls the compiled bottles into the current release and closes the PR. **Do not merge PRs directly.**
