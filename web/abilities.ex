defimpl Canada.Can, for: CedaRealty.User do
  alias CedaRealty.User

  def can?(%User{role: "agent"}, _, _) do
    false
  end

  def can?(%User{role: "manager"}, action, User) when action in [:index, :new, :create] do
    true
  end

  def can?(%User{role: "manager"}, :show, %User{}) do
    true
  end

  def can?(%User{role: "manager"}, action, %User{role: "agent"}) when action in [:edit, :update, :delete] do
    true
  end

  def can?(%User{id: user_id, role: "manager"}, action, %User{id: user_id}) when action in [:edit, :update] do
    true
  end

  def can?(%User{role: "manager"}, _, _) do
    false
  end

  def can?(%User{role: "admin"}, action, User) when action in [:index, :new, :create] do
    true
  end

  def can?(%User{role: "admin"}, :show, %User{}) do
    true
  end

  def can?(%User{role: "admin"}, action, %User{role: target_role}) when action in [:edit, :update, :delete] and target_role in ["agent", "manager"] do
    true
  end

  def can?(%User{id: user_id, role: "admin"}, action, %User{id: user_id}) when action in [:edit, :update] do
    true
  end

  def can?(%User{role: "admin"}, _, _) do
    false
  end

  def can?(%User{role: "sysadmin"} = u, a, r) do
    IO.puts "*****************************************************************************************"
    IO.puts "can?"
    IO.inspect u
    IO.inspect a
    IO.inspect r
    IO.puts "*****************************************************************************************"

    true
  end
end
