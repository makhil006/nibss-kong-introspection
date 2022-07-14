Please replace the below with the appropriate download url in the Dockerfile (or) change the curl command as necessary.
$URL_TO_DOWNLOAD_PLUGIN_ZIP_FROM_YOUR_REPO

STEPS:

1. please run the below command in the folder where you copied the Dockerfile

sudo docker build -t customkongimages:introspection .

2. replace your normal kong image with the above custom image.

# for example wherever you use “kong/kong-gateway:2.8-alpine” in your commands
# replace that with “customkongimages:introspection”

3. Add the below to environment variables in your “sudo docker run -d --name kong-gateway” command

  -e "KONG_PLUGINS=bundled,custom-introspection" \
  -e "LUA_PATH=/usr/share/lua/5.1/?.lua;;" \

The rest of the commands can stay as is.



# Installation steps to run on the server

# create a folder

mkdir $HOME/kong && cd $_
mkdir kong-plugin-custom-introspection && cd $_

# curl to fetch the zip file from your repo to the server. Example:

curl -Lo kong-plugin-custom-introspection.zip '$ZIP_FILE_DOWNLOAD_URL'

# unzip and install

echo y | unzip kong-plugin-custom-introspection.zip
rm kong-plugin-custom-introspection.zip
sudo luarocks make
sudo luarocks pack kong-plugin-custom-introspection 0.1.1-0
sudo luarocks install kong-plugin-custom-introspection-0.1.1-0.all.rock

# EDIT KONG CONF FILE

sudo vi /etc/kong/kong.conf

# modify these two lines inside the conf file like below

plugins = bundled,custom-introspection

lua_package_path = /usr/share/lua/5.1/?.lua;;

# save the changes in conf file and RESTART KONG

sudo /usr/local/bin/kong restart –v


Once the plugin is installed and restarted, then attach the below two plugin on the “getPartialDetailsWithBvn” ROUTE.

# Login to kong manager

# 1. add custom-introspection plugin we just installed to the “getPartialDetailsWithBvn” route
# and configure it using the below values. The rest can be left blank.
# the custom plugin can be found at the very end of all the pre-installed plugins in the Add plugin screen

config.introspection_url:   https://bvn-consent.nibss-plc.com.ng/oxauth/restv1/introspection
config.hide_credentials:   true
config.consumer_by:   username
config.introspect_request:   false
config.host_header:   gluupoc.nibss-plc.com.ng
config.cache_control_header:   no-cache
config.getPartialDetailsWithBvn:   true
config.ttl:   30
config.timeout:   10000
config.keepalive:   60000
config.run_on_preflight:   true


# 2. Add response-transformer-advanced plugin with the below config
# this is to view the beatified response in a tool like postman with properly formatted json

config.add.headers:   Content-Type:application/json




Configuration is done and the API can now be tested with the Bearer token in the Header of “getPartialDetailsWithBvn” request along with the previously existing headers.

Example:

--header 'Authorization: Bearer 2a7e41fe-59dc-488e-ad91-c5a4ea04d611'
