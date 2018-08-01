#!/bin/bash

# Xcode template directories
XCODE_LIB_ROOT_DIR=${HOME}/Library/Developer/Xcode
TEMPLATE_ROOT_DIR=${XCODE_LIB_ROOT_DIR}/Templates
FILE_TEMPLATE_ROOT_DIR=${TEMPLATE_ROOT_DIR}/File\ Templates
FILE_TEMPLATE_DST_DIR=${FILE_TEMPLATE_ROOT_DIR}/Swift\ Templates

# Source directory
SCRIPT_SRC_DIR=$(cd $(dirname $0); pwd)
FILE_TEMPLATE_SRC_DIR=${SCRIPT_SRC_DIR}

# Check directory exists in Library
if [ ! -d ${XCODE_LIB_ROOT_DIR} ] ; then
    echo "Xcode is not installed. (or not started)"
    exit 1
fi

# Create file templates directory if not exist
if [ ! -d "${FILE_TEMPLATE_DST_DIR}" ] ; then
    echo "Create directory: ${FILE_TEMPLATE_DST_DIR}"
    mkdir -p "${FILE_TEMPLATE_DST_DIR}"
    if [ $? -ne 0 ] ; then
        echo "Failed to create directory."
        exit 2
    fi
fi

find "${FILE_TEMPLATE_SRC_DIR}" -d 1 -type d -name "*.xctemplate" | while read dir; do
    template_name=$(basename "$dir")
    dest="${FILE_TEMPLATE_DST_DIR}"
    echo "Copy: ${template_name} -> ${dest}"
    cp -r "$dir" "$dest"
done
