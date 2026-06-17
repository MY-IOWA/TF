locals {
  # 1. Properly formatted list of objects
  location = [
    { code = "IN", location = "centralindia" },
    { code = "AF", location = "southafricanorth" },
    { code = "JW", location = "japanwest" },
  ]

  # 2. Automatically transform the list into a lookup map: {"southafricanorth" = "AF", ...}
  location_code = { for item in local.location : item.location => item.code }

  # 3. Perform your lookup and naming suffix generation
  naming_suffix = "${var.business_unit}-${var.environment}"
}

/*[
    { code = "AF", location = "southafricanorth" },
    { code = "AE", location = "australiaeast" },
    { code = "BS", location = "brazilsouth" },
    { code = "CC", location = "canadacentral" },
    { code = "CI", location = "centralindia" },
    { code = "EU", location = "eastus" },
    { code = "CL", location = "chilecentral" },
    { code = "MC", location = "mexicocentral" },
    { code = "JW", location = "japanwest" },
    { code = "KC", location = "koreacentral" }
  ]*/