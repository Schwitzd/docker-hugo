#!/bin/bash

HUGO_PARAMS="$@"

# Function to check if the current directory contains a Hugo website
check_hugo_site() {
    if [ -f hugo.toml ] || [ -f hugo.yaml ] || [ -f hugo.json ]; then
        echo "Hugo website found in the current directory."
        run_hugo
    else
        echo "No Hugo website found in the current directory."
        read -r -p "Do you want to create a new Hugo website here? (y/n): " response
        if [[ ${response} =~ ^[Yy]$ ]]; then
            create_hugo_site
        else
            echo "Exiting."
            exit 1
        fi
    fi
}

# Function to create a new Hugo website
create_hugo_site() {
    read -r -p "Enter the name for your new Hugo website: " site_name
    read -r -p "Choose the configuration format (TOML/YAML/JSON): " config_format
    case "${config_format}" in
        TOML|toml)
            hugo new site ${site_name} --destination /site
            echo "New Hugo website created with TOML configuration format in the current directory."
            ;;
        YAML|yaml)
            hugo new site ${site_name} --format yaml --destination /site
            echo "New Hugo website created with YAML configuration format in the current directory."
            ;;
        JSON|json)
            hugo new site ${site_name} --format json --destination /site
            echo "New Hugo website created with JSON configuration format in the current directory."
            ;;
        *)
            echo "Invalid configuration format. Exiting."
            exit 1
            ;;
    esac

    # Move files/folders from subdirectory to current directory
    mv "${site_name}"/* .
    # Remove the empty subdirectory created by Hugo
    rm -r "${site_name}"
    # Run Hugo website
    run_hugo
}

# Function to run Hugo with parameters specified during Docker run
run_hugo() {
    echo "Running Hugo with parameters: ${HUGO_PARAMS}"
    hugo ${HUGO_PARAMS}
}

# Main function
main() {
    echo "Checking for Hugo website in the current directory..."
    check_hugo_site
}

# Execute main function
main