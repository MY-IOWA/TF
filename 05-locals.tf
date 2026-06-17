locals {
  # 1. Properly formatted list of objects
  location = [
    { code = "IN", location = "centralindia", business_unit = "HR", environment = "QA" },
    { code = "AF", location = "southafricanorth", business_unit = "FIN", environment = "QA" },
    { code = "JW", location = "japanwest", business_unit = "FIN", environment = "QA" },
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