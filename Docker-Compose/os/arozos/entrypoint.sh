#!/bin/bash
check_web() {
    echo "Checking if the 'web' folder is empty..."

    if [ -z "$(ls -A /arozos/web)" ]; then
        echo "'web' folder is empty. Extracting files from 'web.tar.gz'..."
        tar -xzvf web.tar.gz -C /arozos/
    else
        echo "'web' folder is not empty."
    fi
}

# Call the extra function
check_web

variable_list=("port" "hostname" "enable_hwman" "enable_pwman" "allow_autologin" "allow_cluster" "allow_iot" "allow_mdns" "allow_pkg_install" "allow_ssdp" "bufffile_size" "buffpool_size" "iobuf" "max_upload_size" "uuid")
command="./launcher"
for var_name in "${variable_list[@]}"; do
    if [ -n "${!var_name}" ]; then
        command+=" -${var_name}=${!var_name}"
    fi
done
echo "Running command: $command"
exec $command
