#!/bin/bash
# Copyright 2020 Intel Corporation
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

function error_exit()
{
    echo "[Error]: " ${*}
    exit 1
}

echo ""
echo "====================================================="
echo "STEP 1 :: Stop HL Besu network and destroy containers"
echo "====================================================="
docker-compose down || error_exit "Failed to cleanup Besu network"
echo "Done"

echo ""
echo "====================================================="
echo "STEP 2 :: Stop truffle setup container and destroy"
echo "====================================================="
docker-compose -f docker-compose-truffle.yaml down || error_exit "Failed to cleanup truffle setup"
echo "Done"

echo ""
echo "====================================================="
echo "STEP 3 :: Delete persistent blockchain data"
echo "====================================================="
# To clean up all persistent data for a running node
cd ./besu/node1
sudo rm -rf caches database DATABASE_METADATA.json || error_exit "Failed to cleanup node1"
cd ../node2
sudo rm -rf caches database DATABASE_METADATA.json || error_exit "Failed to cleanup node2"
cd ../../
echo "Done"

echo "Cleanup Successful!!"
echo ""
