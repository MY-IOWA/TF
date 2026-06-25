locals {
  # 1. Properly formatted list of objects
  location = [
    { code = "IN", location = "southindia", business_unit = ["HR", "FIN", "IT"], environment = ["dev", "prod", "QA", "staging"] },
    { code = "AF", location = "southafricanorth", business_unit = ["HR", "FIN", "IT"], environment = ["dev", "prod", "QA", "staging"] },
    { code = "JW", location = "japanwest", business_unit = ["HR", "FIN", "IT"], environment = ["dev", "prod", "QA", "staging"] },
  ]
  # 2. Automatically transform the list into a lookup map: {"southafricanorth" = "AF", ...}
  location_code = { for item in local.location : item.location => item.code }

  # 3. Perform your lookup and naming suffix generation
  naming_suffix = "${local.location[0].business_unit[0]}-${local.location[0].environment[0]}"
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
