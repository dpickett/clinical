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

require "clinical/condition"

require "clinical/sponsor"
require "clinical/lead_sponsor"
require "clinical/agency"
require "clinical/collaborator"

require "clinical/address"
require "clinical/contact"
require "clinical/location"

require "clinical/trial"

require "clinical/collection"
