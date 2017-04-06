#!/bin/bash
#
# Copyright (C) 2016 The CyanogenMod Project
# Copyright (C) 2017 The LineageOS Project
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

set -e

# Load extract_utils and do some sanity checks
MY_DIR="${BASH_SOURCE%/*}"
if [[ ! -d "$MY_DIR" ]]; then MY_DIR="$PWD"; fi

CM_ROOT="$MY_DIR"/../..

HELPER="$CM_ROOT"/vendor/cm/build/tools/extract_utils.sh
if [ ! -f "$HELPER" ]; then
    echo "Unable to find helper script at $HELPER"
    exit 1
fi
. "$HELPER"

# Initialize the helper for common gapps
setup_vendor "$GAPPS_COMMON" "$VENDOR" "$CM_ROOT"

# Copyright headers
write_headers

# Common gapps
write_makefiles "$MY_DIR"/common-proprietary-files.txt

# We are done with common
write_footers

# Reinitialize the helper for target gapps
setup_vendor "$TARGET" "$VENDOR" "$CM_ROOT"

# Copyright headers and guards
write_headers

write_makefiles "$MY_DIR"/proprietary-files-$TARGET.txt
write_makefiles "$MY_DIR"/proprietary-files.txt

# We are done with target
write_footers