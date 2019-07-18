FROM alpine:3.10.1

LABEL "com.github.actions.name"="Create Zip File"
LABEL "com.github.actions.description"="Create a zip file containing specific files from your repository"
LABEL "com.github.actions.icon"="folder-plus"
LABEL "com.github.actions.color"="gray-dark"

LABEL "repository"="https://github.com/montudor/action-zip"
LABEL "homepage"="https://github.com/montudor/action-zip"
LABEL "maintainer"="Monte Hellawell <monte@montudor.com>"

RUN apk add zip
