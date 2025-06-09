Releasing

- When the [overmind CLI](https://github.com/overmindtech/cli) is built and released, for example [v1.8.2](https://github.com/overmindtech/cli/releases/tag/v1.8.2). [Renovate](https://github.com/overmindtech/homebrew-overmind/issues/2) will automatically run and create a pull request. (or you can force it to run from the dashboard)
- For example this one `https://github.com/overmindtech/homebrew-overmind/pull/91`
- Once all the automated tests pass, add a label with pr-pull. This will trigger another automated workflow that pulls the compiled bottles into the current release and closes the PR. **Do not merge PRs directly.**
