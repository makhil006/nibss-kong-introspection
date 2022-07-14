FROM kong/kong-gateway:2.8-alpine

LABEL description="Alpine + Kong 2.8 + kong-plugin-custom-introspection"

ENV CUSTOM_INTROSPECTION_PLUGIN_VERSION=0.2.0-0

USER root

RUN apk update && apk add unzip luarocks curl

RUN curl -Lo nibss-kong-introspection-main.zip 'https://github.com/makhil006/nibss-kong-introspection/archive/refs/heads/main.zip' \
 && echo y | unzip nibss-kong-introspection-main.zip \
 && rm nibss-kong-introspection-main.zip \
 && cd nibss-kong-introspection-main \
 && luarocks make

RUN luarocks pack kong-plugin-custom-introspection ${CUSTOM_INTROSPECTION_PLUGIN_VERSION} \
 && luarocks install kong-plugin-custom-introspection-${CUSTOM_INTROSPECTION_PLUGIN_VERSION}.all.rock

USER kong
