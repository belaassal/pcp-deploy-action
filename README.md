# pcp-deploy-action

Action to send or Deploy files to server using SCP (secure copy).

## Required params

```
-host: SSH host
-port: SSH port
-user: SSH user
-key: RSA private key
-localdir: Local directory
-remotedir: Remote directory
```

## How to deploy

    1- Generate ssh key
    2 - Create git secrets
    3 - create action

## USAGE :

### DEPLOY DIRECTORY

```
name: TestCI
on:
  push:
    branches: [master]
  # Allows you to run this workflow manually from the Actions tab
  workflow_dispatch:
jobs:
  build:
    runs-on: ubuntu-20.04

    steps:
      - uses: actions/checkout@v2
      - name: Deploy
        uses: belaassal/pcp-deploy-action@main
        with:
          host: ${{ secrets.HOST }}
          port: ${{ secrets.PORT }}
          user: ${{ secrets.USER }}
          key: ${{ secrets.KEY }}
          localdir: "/github/workspace/"
          remotedir: "/var/www/"

```

### DEPLOY CHANGED FILE ONLY

```

name: TestCI
on:
  push:
    branches: [master]
  # Allows you to run this workflow manually from the Actions tab
  workflow_dispatch:
jobs:
  build:
    runs-on: ubuntu-20.04
    steps:
      - uses: actions/checkout@v2
        with:
          fetch-depth: 0
      - name: get changed files
        id: getfile
        run: |
          echo "::set-output name=files::$( git diff --name-only ${{ github.event.before }} ${{ github.sha }} | xargs )"
      - name: echo output
        run: |
          echo ${{ steps.getfile.outputs.files }}
      - name: Deploy
        uses: belaassal/pcp-deploy-action@main
        with:
          host: ${{ secrets.HOST }}
          port: ${{ secrets.PORT }}
          user: ${{ secrets.USER }}
          key: ${{ secrets.KEY }}
          files: ${{ steps.getfile.outputs.files }}
          remotedir: "/var/www"

```
