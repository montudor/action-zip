# Zip Files Action

This GitHub action exposes the zip command for use in building/archiving. It is important to note that this action currently only supports Linux.

## Usage

Zipping the directory `dir` into `dir.zip`:

```yaml
- uses: montudor/action-zip@v0.1.1
  with:
    args: zip -qq -r dir.zip dir
```

Unzipping a `dir.zip` file:

```yaml
- uses: montudor/action-zip@v0.1.1
  with:
    args: unzip -qq dir.zip -d dir
```

Zipping a folder from a different work dir

```yaml
- name: Install zip
  uses: montudor/action-zip@v0.1.1

- name: Zip output
  run: zip -qq -r function.zip dist node_modules package.json
  working-directory: path/to/work-dir
```

Reusing the same zip between steps in a `PHP` CI with unit and mutation tests:

```yaml
name: Continuous Integration
on:
  push:
  pull_request:
jobs:
  composer-install:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v1
      - run: composer install --ansi --no-progress --no-interaction --prefer-dist
      - uses: montudor/action-zip@v0.1.1
        with:
          args: zip -qq -r vendor.zip vendor
      - uses: actions/upload-artifact@v2
        with:
          name: vendor.zip
  tests:
    needs: composer-install
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v1
      - uses: actions/download-artifact@v2
        with:
          name: vendor.zip
      - uses: montudor/action-zip@v0.1.1
        with:
          args: unzip -qq vendor.zip -d vendor
      - run: ./vendor/bin/phpunit
  mutation:
    needs: composer-install
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v1
      - uses: actions/download-artifact@v2
        with:
          name: vendor.zip
      - uses: montudor/action-zip@v0.1.1
        with:
          args: unzip -qq vendor.zip -d vendor
      - run: ./vendor/bin/infection
```
