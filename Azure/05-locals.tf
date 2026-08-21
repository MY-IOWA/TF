locals {
  # 1. Properly formatted list of objects
  location = [
    { code = "IN", location = "centralindia", business_unit = "HR", environment = "dev", cidr = "10.0.0.0/16" },
    { code = "SW", location = "swedencentral", business_unit = "HR", environment = "dev", cidr = "10.1.0.0/16" },
    { code = "AF", location = "southafricanorth", business_unit = "HR", environment = "dev", cidr = "10.2.0.0/16" },
    { code = "MC", location = "mexicocentral", business_unit = "HR", environment = "dev", cidr = "10.3.0.0/16" },
    { code = "CL", location = "chilecentral", business_unit = "HR", environment = "dev", cidr = "10.4.0.0/16" },
    { code = "JW", location = "japanwest", business_unit = "HR", environment = "dev", cidr = "10.5.0.0/16" },
    { code = "KC", location = "koreacentral", business_unit = "HR", environment = "dev", cidr = "10.6.0.0/16" },
    { code = "AE", location = "australiaeast", business_unit = "HR", environment = "dev", cidr = "10.7.0.0/16" }
  ]
  # 2. Automatically transform the list into a lookup map: {"southafricanorth" = "AF", ...}
  location_code = { for item in local.location : item.location => item.code }
  location_cidr = { for item in local.location : item.location => item.cidr }

  # 3. Perform your lookup and naming suffix generation
  naming_suffix = "${local.location[0].business_unit}-${local.location[0].environment}"
}
