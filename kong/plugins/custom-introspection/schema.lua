-- This software is copyright Kong Inc. and its licensors.
-- Use of the software is subject to the agreement between your organization
-- and Kong Inc. If there is no such agreement, use is governed by and
-- subject to the terms of the Kong Master Software License Agreement found
-- at https://konghq.com/enterprisesoftwarelicense/.
-- [ END OF LICENSE 0867164ffc95e54f04670b5169c09574bdbd9bba ]

local typedefs = require "kong.db.schema.typedefs"
local handler = require "kong.plugins.oauth2-introspection.handler"
local utils = require "kong.tools.utils"


local function check_user(anonymous)
  if anonymous == "" or utils.is_valid_uuid(anonymous) then
    return true
  end

  return false, "the anonymous user must be empty or a valid uuid"
end


local consumer_by_fields = handler.consumer_by_fields
local CONSUMER_BY_DEFAULT = handler.CONSUMER_BY_DEFAULT


return {
  name = "oauth2-introspection",
  fields = {
    { consumer = typedefs.no_consumer },
    { config = {
      type = "record",
      fields = {
        { introspection_url = typedefs.url { required = true} },
        { path = { type = "string", default = "/bvnconsent/v1/getPartialDetailsWithBvn?bvn=" } },
        { host_header = { type = "string" } },
        { cache_control_header = { type = "string" } },
        { getPartialDetailsWithBvn = { type = "boolean", default = true } },
        { ttl = { type = "number", default = 30 } },
        -- { token_type_hint = { type = "string" } },
        -- { authorization_value = { type = "string", required = true } },
        { timeout = { type = "integer", default = 10000 } },
        { keepalive = { type = "integer", default = 60000 } },
        -- { introspect_request = { type = "boolean", default = false, required = true } },
        -- { hide_credentials = { type = "boolean", default = true } },
        { run_on_preflight = { type = "boolean", default = true, required = true } },
        -- { anonymous = { type = "string", len_min = 0, default = "", custom_validator = check_user } },
        { consumer_by = { type = "string", default = CONSUMER_BY_DEFAULT, one_of = consumer_by_fields, required = true } },
        -- { custom_introspection_headers = {type = "map", keys = { type = "string" }, values = { type = "string" }, default = {}, required = true } },
        -- { custom_claims_forward = {type = "set", elements = { type = "string" }, default = {}, required = true } },
      }}
    },
  },
}
