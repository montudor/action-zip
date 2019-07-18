# Zip Files Action

This GitHub action exposes the zip command for use in building/archiving.

## Usage

An example action config is displayed below:

```
action "Zip" {
  uses = "montudor/action-zip@v0.1.0"
  args = "zip -r output.zip ./path_to_files"
}
```
