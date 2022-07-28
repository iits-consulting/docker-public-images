# docker-public-images

## Note

When creating an image base on alpine please do not fix the version of the package `apk add "bash=5.1.16-r2"`.
Instead, use fuzzy matching `apk add "bash=~5.1"`.
This should be done because the alpine repositories do not keep every version of a programm.
Leading to not reproducible builds.
Additionally, you don't get security updates and patches.
