# jenkins-bench

Some Jenkins Pipelines that build basic devtools or something for
benchmarking on various Jenkins agent (amd64, arm64v8, riscv64).

## About this project

- About Jenkins: See [Jenkins](https://www.jenkins.io/).
- About Jenkins Pipeline: See [Pipeline](https://www.jenkins.io/doc/book/pipeline/).
- Related project:
  - [jaxvanyang/buildpack-deps-ssh-agent](https://github.com/jaxvanyang/buildpack-deps-ssh-agent):
  Set up Jenkins agents used by this project.
- Repo structure:
  - Each Jenkins Pipeline is under its own branch, e.g., GNU Make under `make`.
  - Documents, helper scripts & other resources are under this `main` branch.
  - All these branches should be based on the `base` branch for a clean Git history.
  - Current developing branches:
    - [GNU Make](https://www.gnu.org/software/make): `make`.
    - [A selection of ANSI C benchmarks and programs useful as benchmarks](https://github.com/nfinit/ansibench): `ansibench`.
    - [GCC](https://gcc.gnu.org): `gcc`.
    - [UnixBench](https://github.com/kdlucas/byte-unixbench): `unixbench`.

## Development

Read existing `Jenkinsfile` from `make` or other branches for a quick start.

1. Get the resources needed:

   Append the archive URL to [resources.txt](./resources.txt), `tar.gz` is
   preferred. This kind of change should be committed to the `main` branch.
   After approval, these archives will be downloaded to `/mnt/resources` on
   all Jenkins agents using [get-resources.sh](./get-resources.sh):

   ```bash
   ./get-resources.sh resources.txt /mnt/resources
   ```

2. Create and switch to a new branch based on the `base` branch, for example:

    ```bash
    git switch -c gcc base
    ```

3. Create a new `Jenkinsfile` or use one from an existing branch as template:

   ```bash
   touch Jenkinsfile
   # or
   git checkout make -- Jenkinsfile
   ```

## References

- [Jenkins Pipeline](https://www.jenkins.io/doc/book/pipeline/)
