import Exseed
import Comeonin.Bcrypt

user_id = 1

seed CedaRealty.User do
  id user_id

  username "seshbaugh"

  email "seshbaugh@cedarealty.com"

  encrypted_password hashpwsalt("changeme")

  role "sysadmin"
end

user_id = user_id + 1

seed CedaRealty.User do
  id user_id

  username "sgoff"

  email "sgoff@cedarealty.com"

  encrypted_password hashpwsalt("changeme")

  role "owner"
end
