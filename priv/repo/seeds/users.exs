import Exseed
import Comeonin.Bcrypt

user_id = 1

seed CedaRealty.User do
  id user_id

  username "admin"

  email "admin@cedarealty.com"

  encrypted_password hashpwsalt("changeme")

  role "sysadmin"
end
