import Ecto.Query
import Exseed

profile_id = 1

seed CedaRealty.Profile do
  id profile_id

  user_id CedaRealty.Repo.one(from user in CedaRealty.User, where: user.username == "seshbaugh").id

  office_id nil

  first_name "Sean"

  last_name "Eshbaugh"

  display_name "Sean Eshbaugh"

  slug "sean-eshbaugh"

  title "Sysadmin"

  display_email_address "seshbaugh@cedarealty.com"

  joined_at %Ecto.Date{year: 2011, month: 3, day: 28}

  visible false
end

profile_id = profile_id + 1

seed CedaRealty.Profile do
  id profile_id

  user_id CedaRealty.Repo.one(from user in CedaRealty.User, where: user.username == "sgoff").id

  office_id CedaRealty.Repo.one(from office in CedaRealty.Office, where: office.name == "Plano").id

  first_name "Steve"

  last_name "Goff"

  display_name "Steve Goff"

  slug "steve-goff"

  title "Broker Owner"

  display_email_address "sgoff@cedarealty.com"

  phone_number "972-824-5312"

  website_uri "http://www.cedarealty.com/"

  facebook_uri "http://www.facebook.com/sbgoff"

  twitter_username "goffics"

  bio_body ~s"""
<p>Steve Goff has been a licensed REALTOR&reg;, Broker, Manager and instructor for more than 35 years. A nationally featured real estate speaker, Steve has trained real estate agents and Broker/Managers from coast to coast and has given real estate careers to thousands of successful real estate agents.</p>
<p>Steve is the originator of the advanced training system, Master the KEYS to Success, entrepreneurial course, Imagine, and the CREE certification (Certified Real Estate Entrepreneur). Steve is the founder, President and CEO of CEDA Realty.</p>
<p>He and his wife, Nanette, are residents of Collin County, Texas, and are native Texans with 3 sons and 9 grandchildren.</p>
"""

  years_of_experience 35

  joined_at %Ecto.Date{year: 2011, month: 3, day: 28}

  visible false
end
