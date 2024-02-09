# Chocolatey Package: Node with FDK

This Chocolatey package automates the installation process for Node.js version 18.18.2 and the Freshworks Developer Kit (FDK) on Windows systems. It also provides instructions on how to activate the FDK in a new terminal session.

## Prerequisites

Before installing the FDK, make sure your Chocolatey installation is up to date. You can upgrade Chocolatey to the latest version by running:

```powershell
choco upgrade chocolatey
```

## Installation

First, install the FDK using Chocolatey:

```powershell
choco install fdk
```

## Usage

After installing the FDK, the package performs the following tasks:

1. Downloads and installs Node.js version 18.18.2.
2. Installs the Freshworks Developer Kit (FDK).

Once installed, you can use the FDK by sourcing the `loadFdk.ps1` file in a new PowerShell session using the following command:

```powershell
"C:\fdk\loadFdk.ps1"
```

This command sets up the necessary environment variables and configurations required for using the FDK.

## Verification

To verify that the FDK has been successfully installed, you can check its version by running the following command:

```powershell
fdk -v
```

This command should output the version of the FDK installed on your system.

## Uninstalling FDK

To uninstall the Freshworks Developer Kit (FDK) installed via Chocolatey, run the following command:

```powershell
choco uninstall fdk
```

This command will remove the FDK from your system.

## Note

- Make sure to have Chocolatey installed on your system before running the installation command.

- Make sure to verify if you want to uninstall FDK as this action is irreversible and will remove the package from your system.

## Feedback and Issues

If you encounter any issues or have feedback regarding this package, please report them to <Support email of developer>. Your feedback is highly appreciated and helps improve the package for everyone.

## License

This package is released under the [MIT License](LICENSE). Feel free to modify and distribute it according to your needs.