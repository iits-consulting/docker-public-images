# docker-public-images


## Contributing

Make sure you have the following installed:

- [docker](https://docs.docker.com/get-docker/)
- [pre-commit](https://pre-commit.com/)

Then initially you need to create the commit-hooks with pre-commit by doing:

```shell
$ pre-commit install
# pre-commit installed at .git/hooks/pre-commit
```

This will make sure all Dockerfiles comply with hadolint whenever you try to commit something. Otherwise, you can't push.

To update the pre-commit-hooks you just need to run `pre-commit install` again.

To run them without git you can just run ` pre-commit run --all-files`.
