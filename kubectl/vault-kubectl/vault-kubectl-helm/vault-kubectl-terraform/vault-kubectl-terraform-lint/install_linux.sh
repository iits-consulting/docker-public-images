#!/bin/bash -e
# Original Release/Script downloaded from https://github.com/terraform-linters/tflint/blob/master/install_linux.sh
# The original script has been modified in order to make it run via docker

echo -e "\n\n===================================================="

version=${TFLINT_VERSION}

echo "Downloading TFLint $version"
curl -L -o /tmp/tflint.zip "https://github.com/terraform-linters/tflint/releases/download/${version}/tflint_linux_amd64.zip"
retVal=$?
if [ $retVal -ne 0 ]; then
  echo "Failed to download tflint_${os}.zip"
  exit $retVal
else
  echo "Download was successfully"
fi

echo -e "\n\n===================================================="
echo "Unpacking /tmp/tflint.zip ..."
unzip /tmp/tflint.zip -d /tmp/
echo "Installing /tmp/tflint to /usr/local/bin..."


mkdir -p /usr/local/bin
install -b -c -v /tmp/tflint /usr/local/bin/
retVal=$?
if [ $retVal -ne 0 ]; then
  echo "Failed to install tflint"
  exit $retVal
else
  echo "tflint installed at /usr/local/bin/ successfully"
fi

echo "Cleaning /tmp/tflint.zip and /tmp/tflint ..."
rm /tmp/tflint.zip /tmp/tflint

echo -e "\n\n===================================================="
echo "Current tflint version"
tflint -v