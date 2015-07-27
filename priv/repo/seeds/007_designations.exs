import Exseed

logos_source_path = Path.expand("./priv/repo/fixtures/designations")

logos_destination_path = Path.expand("./priv/static/system/designations/logos")

File.rm_rf(logos_destination_path)

File.mkdir_p!(logos_destination_path)

designation_id = 1

seed CedaRealty.Designation do
  id designation_id

  name "Accredited Buyer's Representative"

  slug "accredited-buyers-representative"

  abbreviation "ABR"

  description ""

  source_file_name = "abr.png"

  logo_source_path = Path.join(logos_source_path, source_file_name)

  checksum = :crypto.hash(:sha512, File.read!(logo_source_path)) |> Base.encode16 |> String.downcase

  destination_file_name = checksum <> ".png"

  logo_destination_path = Path.join(logos_destination_path, destination_file_name)

  logo_path destination_file_name

  logo_file_size File.stat!(logo_source_path).size

  logo_file_content_type "image/png"

  logo_original_file_name source_file_name

  logo_checksum checksum

  File.cp!(logo_source_path, logo_destination_path)

  visible true
end

designation_id = designation_id + 1

seed CedaRealty.Designation do
  id designation_id

  name "Accredited Buyer Representative Manager"

  slug "accredited-buyer-representative-manager"

  abbreviation "ABRM"

  description ""

  source_file_name = "abrm.png"

  logo_source_path = Path.join(logos_source_path, source_file_name)

  checksum = :crypto.hash(:sha512, File.read!(logo_source_path)) |> Base.encode16 |> String.downcase

  destination_file_name = checksum <> ".png"

  logo_destination_path = Path.join(logos_destination_path, destination_file_name)

  logo_path destination_file_name

  logo_file_size File.stat!(logo_source_path).size

  logo_file_content_type "image/png"

  logo_original_file_name source_file_name

  logo_checksum checksum

  File.cp!(logo_source_path, logo_destination_path)

  visible true
end

designation_id = designation_id + 1

seed CedaRealty.Designation do
  id designation_id

  name "At Home With Diversity"

  slug "at-home-with-diversity"

  abbreviation "AHWD"

  description ""

  source_file_name = "ahwd.png"

  logo_source_path = Path.join(logos_source_path, source_file_name)

  checksum = :crypto.hash(:sha512, File.read!(logo_source_path)) |> Base.encode16 |> String.downcase

  destination_file_name = checksum <> ".png"

  logo_destination_path = Path.join(logos_destination_path, destination_file_name)

  logo_path destination_file_name

  logo_file_size File.stat!(logo_source_path).size

  logo_file_content_type "image/png"

  logo_original_file_name source_file_name

  logo_checksum checksum

  File.cp!(logo_source_path, logo_destination_path)

  visible true
end

designation_id = designation_id + 1

seed CedaRealty.Designation do
  id designation_id

  name "Accredited Land Consultant"

  slug "accredited-land-consultant"

  abbreviation "ALC"

  description ""

  source_file_name = "alc.png"

  logo_source_path = Path.join(logos_source_path, source_file_name)

  checksum = :crypto.hash(:sha512, File.read!(logo_source_path)) |> Base.encode16 |> String.downcase

  destination_file_name = checksum <> ".png"

  logo_destination_path = Path.join(logos_destination_path, destination_file_name)

  logo_path destination_file_name

  logo_file_size File.stat!(logo_source_path).size

  logo_file_content_type "image/png"

  logo_original_file_name source_file_name

  logo_checksum checksum

  File.cp!(logo_source_path, logo_destination_path)

  visible true
end

designation_id = designation_id + 1

seed CedaRealty.Designation do
  id designation_id

  name "Accredited Luxury Home Specialist"

  slug "accredited-luxury-home-specialist"

  abbreviation "ALHS"

  description ""

  source_file_name = "alhs.png"

  logo_source_path = Path.join(logos_source_path, source_file_name)

  checksum = :crypto.hash(:sha512, File.read!(logo_source_path)) |> Base.encode16 |> String.downcase

  destination_file_name = checksum <> ".png"

  logo_destination_path = Path.join(logos_destination_path, destination_file_name)

  logo_path destination_file_name

  logo_file_size File.stat!(logo_source_path).size

  logo_file_content_type "image/png"

  logo_original_file_name source_file_name

  logo_checksum checksum

  File.cp!(logo_source_path, logo_destination_path)

  visible true
end

designation_id = designation_id + 1

seed CedaRealty.Designation do
  id designation_id

  name "Certified Commercial Investment Member"

  slug "certified-commercial-investment-member"

  abbreviation "CCIM"

  description ""

  source_file_name = "ccim.png"

  logo_source_path = Path.join(logos_source_path, source_file_name)

  checksum = :crypto.hash(:sha512, File.read!(logo_source_path)) |> Base.encode16 |> String.downcase

  destination_file_name = checksum <> ".png"

  logo_destination_path = Path.join(logos_destination_path, destination_file_name)

  logo_path destination_file_name

  logo_file_size File.stat!(logo_source_path).size

  logo_file_content_type "image/png"

  logo_original_file_name source_file_name

  logo_checksum checksum

  File.cp!(logo_source_path, logo_destination_path)

  visible true
end

designation_id = designation_id + 1

seed CedaRealty.Designation do
  id designation_id

  name "Certified Distressed Property Expert"

  slug "certified-distressed-property-expert"

  abbreviation "CDPE"

  description ""

  source_file_name = "cdpe.png"

  logo_source_path = Path.join(logos_source_path, source_file_name)

  checksum = :crypto.hash(:sha512, File.read!(logo_source_path)) |> Base.encode16 |> String.downcase

  destination_file_name = checksum <> ".png"

  logo_destination_path = Path.join(logos_destination_path, destination_file_name)

  logo_path destination_file_name

  logo_file_size File.stat!(logo_source_path).size

  logo_file_content_type "image/png"

  logo_original_file_name source_file_name

  logo_checksum checksum

  File.cp!(logo_source_path, logo_destination_path)

  visible true
end

designation_id = designation_id + 1

seed CedaRealty.Designation do
  id designation_id

  name "Certified International Property Specialist"

  slug "certified-international-property-specialist"

  abbreviation "CIPS"

  description ""

  source_file_name = "cips.png"

  logo_source_path = Path.join(logos_source_path, source_file_name)

  checksum = :crypto.hash(:sha512, File.read!(logo_source_path)) |> Base.encode16 |> String.downcase

  destination_file_name = checksum <> ".png"

  logo_destination_path = Path.join(logos_destination_path, destination_file_name)

  logo_path destination_file_name

  logo_file_size File.stat!(logo_source_path).size

  logo_file_content_type "image/png"

  logo_original_file_name source_file_name

  logo_checksum checksum

  File.cp!(logo_source_path, logo_destination_path)

  visible true
end

designation_id = designation_id + 1

seed CedaRealty.Designation do
  id designation_id

  name "Certified Property Manager"

  slug "certified-property-manager"

  abbreviation "CPM"

  description ""

  source_file_name = "cpm.png"

  logo_source_path = Path.join(logos_source_path, source_file_name)

  checksum = :crypto.hash(:sha512, File.read!(logo_source_path)) |> Base.encode16 |> String.downcase

  destination_file_name = checksum <> ".png"

  logo_destination_path = Path.join(logos_destination_path, destination_file_name)

  logo_path destination_file_name

  logo_file_size File.stat!(logo_source_path).size

  logo_file_content_type "image/png"

  logo_original_file_name source_file_name

  logo_checksum checksum

  File.cp!(logo_source_path, logo_destination_path)

  visible true
end

designation_id = designation_id + 1

seed CedaRealty.Designation do
  id designation_id

  name "Certified Real Estate Brokerage Manager"

  slug "certified-real-estate-brokerage-manager"

  abbreviation "CRB"

  description ""

  source_file_name = "crb.png"

  logo_source_path = Path.join(logos_source_path, source_file_name)

  checksum = :crypto.hash(:sha512, File.read!(logo_source_path)) |> Base.encode16 |> String.downcase

  destination_file_name = checksum <> ".png"

  logo_destination_path = Path.join(logos_destination_path, destination_file_name)

  logo_path destination_file_name

  logo_file_size File.stat!(logo_source_path).size

  logo_file_content_type "image/png"

  logo_original_file_name source_file_name

  logo_checksum checksum

  File.cp!(logo_source_path, logo_destination_path)

  visible true
end

designation_id = designation_id + 1

seed CedaRealty.Designation do
  id designation_id

  name "Certified Residential Specialist"

  slug "certified-residential-specialist"

  abbreviation "CRS"

  description ""

  source_file_name = "crs.png"

  logo_source_path = Path.join(logos_source_path, source_file_name)

  checksum = :crypto.hash(:sha512, File.read!(logo_source_path)) |> Base.encode16 |> String.downcase

  destination_file_name = checksum <> ".png"

  logo_destination_path = Path.join(logos_destination_path, destination_file_name)

  logo_path destination_file_name

  logo_file_size File.stat!(logo_source_path).size

  logo_file_content_type "image/png"

  logo_original_file_name source_file_name

  logo_checksum checksum

  File.cp!(logo_source_path, logo_destination_path)

  visible true
end

designation_id = designation_id + 1

seed CedaRealty.Designation do
  id designation_id

  name "Counselor of Real Estate"

  slug "counselor-of-real-estate"

  abbreviation "CRE"

  description ""

  source_file_name = "cre.png"

  logo_source_path = Path.join(logos_source_path, source_file_name)

  checksum = :crypto.hash(:sha512, File.read!(logo_source_path)) |> Base.encode16 |> String.downcase

  destination_file_name = checksum <> ".png"

  logo_destination_path = Path.join(logos_destination_path, destination_file_name)

  logo_path destination_file_name

  logo_file_size File.stat!(logo_source_path).size

  logo_file_content_type "image/png"

  logo_original_file_name source_file_name

  logo_checksum checksum

  File.cp!(logo_source_path, logo_destination_path)

  visible true
end

designation_id = designation_id + 1

seed CedaRealty.Designation do
  id designation_id

  name "e-PRO"

  slug "e-pro"

  abbreviation "EPRO"

  description ""

  source_file_name = "epro.png"

  logo_source_path = Path.join(logos_source_path, source_file_name)

  checksum = :crypto.hash(:sha512, File.read!(logo_source_path)) |> Base.encode16 |> String.downcase

  destination_file_name = checksum <> ".png"

  logo_destination_path = Path.join(logos_destination_path, destination_file_name)

  logo_path destination_file_name

  logo_file_size File.stat!(logo_source_path).size

  logo_file_content_type "image/png"

  logo_original_file_name source_file_name

  logo_checksum checksum

  File.cp!(logo_source_path, logo_destination_path)

  visible true
end

designation_id = designation_id + 1

seed CedaRealty.Designation do
  id designation_id

  name "General Accredited Appraiser"

  slug "general-accredited-appraiser"

  abbreviation "GAA"

  description ""

  source_file_name = "gaa.png"

  logo_source_path = Path.join(logos_source_path, source_file_name)

  checksum = :crypto.hash(:sha512, File.read!(logo_source_path)) |> Base.encode16 |> String.downcase

  destination_file_name = checksum <> ".png"

  logo_destination_path = Path.join(logos_destination_path, destination_file_name)

  logo_path destination_file_name

  logo_file_size File.stat!(logo_source_path).size

  logo_file_content_type "image/png"

  logo_original_file_name source_file_name

  logo_checksum checksum

  File.cp!(logo_source_path, logo_destination_path)

  visible true
end

designation_id = designation_id + 1

seed CedaRealty.Designation do
  id designation_id

  name "Green"

  slug "green"

  abbreviation "GREEN"

  description ""

  source_file_name = "green.png"

  logo_source_path = Path.join(logos_source_path, source_file_name)

  checksum = :crypto.hash(:sha512, File.read!(logo_source_path)) |> Base.encode16 |> String.downcase

  destination_file_name = checksum <> ".png"

  logo_destination_path = Path.join(logos_destination_path, destination_file_name)

  logo_path destination_file_name

  logo_file_size File.stat!(logo_source_path).size

  logo_file_content_type "image/png"

  logo_original_file_name source_file_name

  logo_checksum checksum

  File.cp!(logo_source_path, logo_destination_path)

  visible true
end

designation_id = designation_id + 1

seed CedaRealty.Designation do
  id designation_id

  name "Graduate Realtor Institute"

  slug "graduate-realtor-institute"

  abbreviation "GRI"

  description ""

  source_file_name = "gri.png"

  logo_source_path = Path.join(logos_source_path, source_file_name)

  checksum = :crypto.hash(:sha512, File.read!(logo_source_path)) |> Base.encode16 |> String.downcase

  destination_file_name = checksum <> ".png"

  logo_destination_path = Path.join(logos_destination_path, destination_file_name)

  logo_path destination_file_name

  logo_file_size File.stat!(logo_source_path).size

  logo_file_content_type "image/png"

  logo_original_file_name source_file_name

  logo_checksum checksum

  File.cp!(logo_source_path, logo_destination_path)

  visible true
end

designation_id = designation_id + 1

seed CedaRealty.Designation do
  id designation_id

  name "Institute for Home Luxury Marketing Certification"

  slug "institute-for-home-luxury-marketing-certification"

  abbreviation "IHLM"

  description ""

  source_file_name = "ihlm.png"

  logo_source_path = Path.join(logos_source_path, source_file_name)

  checksum = :crypto.hash(:sha512, File.read!(logo_source_path)) |> Base.encode16 |> String.downcase

  destination_file_name = checksum <> ".png"

  logo_destination_path = Path.join(logos_destination_path, destination_file_name)

  logo_path destination_file_name

  logo_file_size File.stat!(logo_source_path).size

  logo_file_content_type "image/png"

  logo_original_file_name source_file_name

  logo_checksum checksum

  File.cp!(logo_source_path, logo_destination_path)

  visible true
end

designation_id = designation_id + 1

seed CedaRealty.Designation do
  id designation_id

  name "International Real Estate Specialist"

  slug "international-real-estate-specialist"

  abbreviation "IRES"

  description ""

  source_file_name = "ires.png"

  logo_source_path = Path.join(logos_source_path, source_file_name)

  checksum = :crypto.hash(:sha512, File.read!(logo_source_path)) |> Base.encode16 |> String.downcase

  destination_file_name = checksum <> ".png"

  logo_destination_path = Path.join(logos_destination_path, destination_file_name)

  logo_path destination_file_name

  logo_file_size File.stat!(logo_source_path).size

  logo_file_content_type "image/png"

  logo_original_file_name source_file_name

  logo_checksum checksum

  File.cp!(logo_source_path, logo_destination_path)

  visible true
end

designation_id = designation_id + 1

seed CedaRealty.Designation do
  id designation_id

  name "Performance Management Network"

  slug "performance-management-network"

  abbreviation "PMN"

  description ""

  source_file_name = "pmn.png"

  logo_source_path = Path.join(logos_source_path, source_file_name)

  checksum = :crypto.hash(:sha512, File.read!(logo_source_path)) |> Base.encode16 |> String.downcase

  destination_file_name = checksum <> ".png"

  logo_destination_path = Path.join(logos_destination_path, destination_file_name)

  logo_path destination_file_name

  logo_file_size File.stat!(logo_source_path).size

  logo_file_content_type "image/png"

  logo_original_file_name source_file_name

  logo_checksum checksum

  File.cp!(logo_source_path, logo_destination_path)

  visible true
end

designation_id = designation_id + 1

seed CedaRealty.Designation do
  id designation_id

  name "Residential Accredited Appraiser"

  slug "residential-accredited-appraiser"

  abbreviation "RAA"

  description ""

  source_file_name = "raa.png"

  logo_source_path = Path.join(logos_source_path, source_file_name)

  checksum = :crypto.hash(:sha512, File.read!(logo_source_path)) |> Base.encode16 |> String.downcase

  destination_file_name = checksum <> ".png"

  logo_destination_path = Path.join(logos_destination_path, destination_file_name)

  logo_path destination_file_name

  logo_file_size File.stat!(logo_source_path).size

  logo_file_content_type "image/png"

  logo_original_file_name source_file_name

  logo_checksum checksum

  File.cp!(logo_source_path, logo_destination_path)

  visible true
end

designation_id = designation_id + 1

seed CedaRealty.Designation do
  id designation_id

  name "Realtor Association Certified Executive"

  slug "realtor-association-certified-executive"

  abbreviation "RCE"

  description ""

  source_file_name = "rce.png"

  logo_source_path = Path.join(logos_source_path, source_file_name)

  checksum = :crypto.hash(:sha512, File.read!(logo_source_path)) |> Base.encode16 |> String.downcase

  destination_file_name = checksum <> ".png"

  logo_destination_path = Path.join(logos_destination_path, destination_file_name)

  logo_path destination_file_name

  logo_file_size File.stat!(logo_source_path).size

  logo_file_content_type "image/png"

  logo_original_file_name source_file_name

  logo_checksum checksum

  File.cp!(logo_source_path, logo_destination_path)

  visible true
end

designation_id = designation_id + 1

seed CedaRealty.Designation do
  id designation_id

  name "Real Estate Professional Assistant"

  slug "real-estate-professional-assistant"

  abbreviation "REPA"

  description ""

  source_file_name = "repa.png"

  logo_source_path = Path.join(logos_source_path, source_file_name)

  checksum = :crypto.hash(:sha512, File.read!(logo_source_path)) |> Base.encode16 |> String.downcase

  destination_file_name = checksum <> ".png"

  logo_destination_path = Path.join(logos_destination_path, destination_file_name)

  logo_path destination_file_name

  logo_file_size File.stat!(logo_source_path).size

  logo_file_content_type "image/png"

  logo_original_file_name source_file_name

  logo_checksum checksum

  File.cp!(logo_source_path, logo_destination_path)

  visible true
end

designation_id = designation_id + 1

seed CedaRealty.Designation do
  id designation_id

  name "Resort and Second-Home Property Specialist"

  slug "resort-and-second-home-property-specialist"

  abbreviation "RSPS"

  description ""

  source_file_name = "rsps.png"

  logo_source_path = Path.join(logos_source_path, source_file_name)

  checksum = :crypto.hash(:sha512, File.read!(logo_source_path)) |> Base.encode16 |> String.downcase

  destination_file_name = checksum <> ".png"

  logo_destination_path = Path.join(logos_destination_path, destination_file_name)

  logo_path destination_file_name

  logo_file_size File.stat!(logo_source_path).size

  logo_file_content_type "image/png"

  logo_original_file_name source_file_name

  logo_checksum checksum

  File.cp!(logo_source_path, logo_destination_path)

  visible true
end

designation_id = designation_id + 1

seed CedaRealty.Designation do
  id designation_id

  name "Short Sales & Foreclosure Resource"

  slug "short-sales-and-foreclosure-resource"

  abbreviation "SFR"

  description ""

  source_file_name = "sfr.png"

  logo_source_path = Path.join(logos_source_path, source_file_name)

  checksum = :crypto.hash(:sha512, File.read!(logo_source_path)) |> Base.encode16 |> String.downcase

  destination_file_name = checksum <> ".png"

  logo_destination_path = Path.join(logos_destination_path, destination_file_name)

  logo_path destination_file_name

  logo_file_size File.stat!(logo_source_path).size

  logo_file_content_type "image/png"

  logo_original_file_name source_file_name

  logo_checksum checksum

  File.cp!(logo_source_path, logo_destination_path)

  visible true
end

designation_id = designation_id + 1

seed CedaRealty.Designation do
  id designation_id

  name "Society of Industrial and Office Realtors"

  slug "society-of-industrial-and-office-realtors"

  abbreviation "SIOR"

  description ""

  source_file_name = "sior.png"

  logo_source_path = Path.join(logos_source_path, source_file_name)

  checksum = :crypto.hash(:sha512, File.read!(logo_source_path)) |> Base.encode16 |> String.downcase

  destination_file_name = checksum <> ".png"

  logo_destination_path = Path.join(logos_destination_path, destination_file_name)

  logo_path destination_file_name

  logo_file_size File.stat!(logo_source_path).size

  logo_file_content_type "image/png"

  logo_original_file_name source_file_name

  logo_checksum checksum

  File.cp!(logo_source_path, logo_destination_path)

  visible true
end

designation_id = designation_id + 1

seed CedaRealty.Designation do
  id designation_id

  name "Seniors Real Estate Specialist"

  slug "seniors-real-estate-specialist"

  abbreviation "SRES"

  description ""

  source_file_name = "sres.png"

  logo_source_path = Path.join(logos_source_path, source_file_name)

  checksum = :crypto.hash(:sha512, File.read!(logo_source_path)) |> Base.encode16 |> String.downcase

  destination_file_name = checksum <> ".png"

  logo_destination_path = Path.join(logos_destination_path, destination_file_name)

  logo_path destination_file_name

  logo_file_size File.stat!(logo_source_path).size

  logo_file_content_type "image/png"

  logo_original_file_name source_file_name

  logo_checksum checksum

  File.cp!(logo_source_path, logo_destination_path)

  visible true
end

designation_id = designation_id + 1

seed CedaRealty.Designation do
  id designation_id

  name "Texas Affordable Housing Specialist"

  slug "texas-affordable-housing-specialist"

  abbreviation "TAHS"

  description ""

  source_file_name = "tahs.png"

  logo_source_path = Path.join(logos_source_path, source_file_name)

  checksum = :crypto.hash(:sha512, File.read!(logo_source_path)) |> Base.encode16 |> String.downcase

  destination_file_name = checksum <> ".png"

  logo_destination_path = Path.join(logos_destination_path, destination_file_name)

  logo_path destination_file_name

  logo_file_size File.stat!(logo_source_path).size

  logo_file_content_type "image/png"

  logo_original_file_name source_file_name

  logo_checksum checksum

  File.cp!(logo_source_path, logo_destination_path)

  visible true
end

designation_id = designation_id + 1

seed CedaRealty.Designation do
  id designation_id

  name "Transnational Referral Certification"

  slug "transnational-referral-certification"

  abbreviation "TRC"

  description ""

  source_file_name = "trc.png"

  logo_source_path = Path.join(logos_source_path, source_file_name)

  checksum = :crypto.hash(:sha512, File.read!(logo_source_path)) |> Base.encode16 |> String.downcase

  destination_file_name = checksum <> ".png"

  logo_destination_path = Path.join(logos_destination_path, destination_file_name)

  logo_path destination_file_name

  logo_file_size File.stat!(logo_source_path).size

  logo_file_content_type "image/png"

  logo_original_file_name source_file_name

  logo_checksum checksum

  File.cp!(logo_source_path, logo_destination_path)

  visible true
end
