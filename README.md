# Cous Script Manager Installer
CSMI provides an easy way to install and setup Cous Script Manager, at scale.

## Installation
The recommended way to install CSM is through running:
```bash
curl -fsSL https://raw.githubusercontent.com/cousdev/csm-installer/main/install.sh | bash
```

Alternatively, you can find compiled binaries in the Releases tab.

## How to use CSM

### First time config
The first time you use CSM, you'll need to go through the configuration.
Run:
```bash
csm
```

Read and follow the instructions.

### Running scripts locally
You can run scripts locally via:
```bash
csm <path_to_csmp>
```

### Downloading scripts from the web
You can also download scripts via the web:
```bash
csm download <script_name_from_gh>
```
Downloading the script does not execute it. The script will be downloaded to wherever you were running the binary from.

