
set -e

git diff release-1.11.10 . > nginx-location-verify-client.patch

sed -ie 's/auto\/configure/configure/g' nginx-location-verify-client.patch

