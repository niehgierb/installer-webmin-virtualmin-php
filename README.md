# webmin-virtualmin-php8_1: First Installation Script

this script is a comprehensive, interactive Bash script designed to streamline the setup and provisioning of essential tools and software on a new machine. It ensures quick and error-free installations, saving you valuable time.

## Features
- Updates and upgrades the system.
- Installs Webmin for web-based system administration.
- Installs Virtualmin for virtual hosting management.
- Installs PHP 8.1 with commonly used extensions.
- Installs the latest version of Composer for PHP dependency management.

## Usage

### One-Line Installation Command

To execute the script directly from GitHub, run the following command:

```bash
bash <(curl -s https://raw.githubusercontent.com/niehgierb/installer-webmin-virtualmin-php/main/webmin-virtualmin-php8_1.sh)
```

### Clone and Run Manually

Alternatively, you can clone this repository and run the script manually:

```bash
git clone https://github.com/niehgierb/installer-webmin-virtualmin-php.git
cd installer-webmin-virtualmin-php
chmod +x webmin-virtualmin-php8_1.sh
sudo ./webmin-virtualmin-php8_1.sh
```

## Prerequisites
- A Linux-based system with `sudo` privileges.
- Stable internet connection for package downloads.

## Notes
- The script checks for root privileges and exits if not run with `sudo`.
- You can skip any installation step interactively by answering `n` when prompted.

## Contributions
Feel free to fork the repository, submit issues, or contribute enhancements. All contributions are welcome!
