package = "kong-plugin-custom-introspection"
version = "0.1.1-0"

source = {
  url = "",
  tag = "0.1.1"
}

description = {
  summary = "Kong custom introspection Plugin",
}

build = {
  type = "builtin",
  modules = {
    ["kong.plugins.custom-introspection.handler"] = "kong/plugins/custom-introspection/handler.lua",
    ["kong.plugins.custom-introspection.schema"] = "kong/plugins/custom-introspection/schema.lua",
  }
}
