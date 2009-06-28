$LOAD_PATH.unshift(File.dirname(__FILE__))

require "will_paginate"
require "httparty"
require "happymapper"

require "clinical/extensions"

require "clinical/status"
require "clinical/intervention"
require "clinical/outcome"
require "clinical/primary_outcome"
require "clinical/secondary_outcome"

require "clinical/trial"

require "clinical/collection"
