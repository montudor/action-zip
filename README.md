# Zip Files Action

This GitHub action exposes the zip command for use in building/archiving. It is important to note that this action currently only supports Linux.

## Usage

Zipping the directory `vendor` into `vendor.zip`:

```yaml
- uses: montudor/action-zip@v0.1.0
  with:
    args: zip -qq -r ./dir.zip ./dir
```

Unzipping a `vendor.zip` file:

```yaml
- uses: montudor/action-zip@v0.1.0
  with:
    args: unzip -qq dir.zip -d ./dir
```

Reusing the same zip between steps in a `PHP` CI with unit and mutation tests:

*Note that we're putting the zip in the `vendor-zip` directory, this is required 
because the artifact upload/download expects a directory not a file.*

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
      - run: mkdir vendor-zip
      - uses: montudor/action-zip@v0.1.0
        with:
          args: zip -qq -r ./vendor-zip/vendor.zip ./vendor
      - uses: actions/upload-artifact@master
        with:
          name: vendor
          path: vendor-zip
  tests:
    needs: composer-install
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v1
      - uses: actions/download-artifact@master
        with:
          name: vendor
          path: vendor-zip
      - uses: montudor/action-zip@v0.1.0
        with:
          args: unzip -qq ./vendor-zip/vendor.zip -d ./vendor
      - run: rm -Rf ./vendor-zip
      - run: ./vendor/bin/phpunit
  mutation:
    needs: composer-install
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v1
      - uses: actions/download-artifact@master
        with:
          name: vendor
          path: vendor-zip
      - uses: montudor/action-zip@v0.1.0
        with:
          args: unzip -qq ./vendor-zip/vendor.zip -d ./vendor
      - run: rm -Rf ./vendor-zip
      - run: ./vendor/bin/infection
```
