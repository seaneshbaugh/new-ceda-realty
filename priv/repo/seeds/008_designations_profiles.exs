import Ecto.Query
import Exseed

abr = CedaRealty.Repo.one(from d in CedaRealty.Designation, where: d.name == "Accredited Buyer's Representative")
abrm = CedaRealty.Repo.one(from d in CedaRealty.Designation, where: d.name == "Accredited Buyer Representative Manager")
ahwd = CedaRealty.Repo.one(from d in CedaRealty.Designation, where: d.name == "At Home With Diversity")
alc = CedaRealty.Repo.one(from d in CedaRealty.Designation, where: d.name == "Accredited Land Consultant")
alhs = CedaRealty.Repo.one(from d in CedaRealty.Designation, where: d.name == "Accredited Luxury Home Specialist")
ccim = CedaRealty.Repo.one(from d in CedaRealty.Designation, where: d.name == "Certified Commercial Investment Member")
cdpe = CedaRealty.Repo.one(from d in CedaRealty.Designation, where: d.name == "Certified Distressed Property Expert")
cips = CedaRealty.Repo.one(from d in CedaRealty.Designation, where: d.name == "Certified International Property Specialist")
cpm = CedaRealty.Repo.one(from d in CedaRealty.Designation, where: d.name == "Certified Property Manager")
crb = CedaRealty.Repo.one(from d in CedaRealty.Designation, where: d.name == "Certified Real Estate Brokerage Manager")
cre = CedaRealty.Repo.one(from d in CedaRealty.Designation, where: d.name == "Counselor of Real Estate")
crs = CedaRealty.Repo.one(from d in CedaRealty.Designation, where: d.name == "Certified Residential Specialist")
epro = CedaRealty.Repo.one(from d in CedaRealty.Designation, where: d.name == "e-PRO")
gaa = CedaRealty.Repo.one(from d in CedaRealty.Designation, where: d.name == "General Accredited Appraiser")
green = CedaRealty.Repo.one(from d in CedaRealty.Designation, where: d.name == "Green")
gri = CedaRealty.Repo.one(from d in CedaRealty.Designation, where: d.name == "Graduate Realtor Institute")
ihlm = CedaRealty.Repo.one(from d in CedaRealty.Designation, where: d.name == "Institute for Home Luxury Marketing Certification")
ires = CedaRealty.Repo.one(from d in CedaRealty.Designation, where: d.name == "International Real Estate Specialist")
pmn = CedaRealty.Repo.one(from d in CedaRealty.Designation, where: d.name == "Performance Management Network")
raa = CedaRealty.Repo.one(from d in CedaRealty.Designation, where: d.name == "Residential Accredited Appraiser")
rce = CedaRealty.Repo.one(from d in CedaRealty.Designation, where: d.name == "Realtor Association Certified Executive")
repa = CedaRealty.Repo.one(from d in CedaRealty.Designation, where: d.name == "Real Estate Professional Assistant")
rsps = CedaRealty.Repo.one(from d in CedaRealty.Designation, where: d.name == "Resort and Second-Home Property Specialist")
sfr = CedaRealty.Repo.one(from d in CedaRealty.Designation, where: d.name == "Short Sales & Foreclosure Resource")
sior = CedaRealty.Repo.one(from d in CedaRealty.Designation, where: d.name == "Society of Industrial and Office Realtors")
sres = CedaRealty.Repo.one(from d in CedaRealty.Designation, where: d.name == "Seniors Real Estate Specialist")
tahs = CedaRealty.Repo.one(from d in CedaRealty.Designation, where: d.name == "Texas Affordable Housing Specialist")
trc = CedaRealty.Repo.one(from d in CedaRealty.Designation, where: d.name == "Transnational Referral Certification")

steve_goff = CedaRealty.Repo.one(from profile in CedaRealty.Profile, where: profile.slug == "steve-goff")

designation_profile_id = 1

[cdpe, crb, ires, sfr] |> Stream.with_index |> Enum.each fn {designation, index} ->
  seed CedaRealty.DesignationProfile do
    id designation_profile_id + index

    designation_id designation.id

    profile_id steve_goff.id
  end
end
