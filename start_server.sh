#!/bin/bash

# Function to install Apache
install_apache() {
    echo "Installing Apache..."
    if command -v yum &> /dev/null; then
        # For Red Hat-based distributions
        yum install -y httpd
    elif command -v apt-get &> /dev/null; then
        # For Debian-based distributions
        apt-get install -y apache2
    elif command -v dnf &> /dev/null; then
        # For Fedora
        dnf install -y httpd
    else
        echo "No supported package manager found. Please install Apache manually."
        exit 1
    fi
}

# Check if Apache is installed
if ! command -v httpd &> /dev/null && ! command -v apache2 &> /dev/null; then
    install_apache
fi

# Copy the HTML file to the Apache web directory
cp /home/ubuntu/my-web-app/index.html /var/www/html/

# Start Apache service
if command -v systemctl &> /dev/null; then
    systemctl restart httpd || systemctl restart apache2
else
    service httpd restart || service apache2 restart
fi

echo "Web server started and application deployed."
