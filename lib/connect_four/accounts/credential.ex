defmodule ConnectFour.Accounts.Credential do
  use Ecto.Schema
  import Ecto.Changeset


  schema "credentials" do
    field :email, :string
    field :password, :string, virtual: true
    field :password_confirmation, :string, virtual: true
    field :password_hash, :string
    belongs_to :user, ConnectFour.Accounts.User

    timestamps()
  end

  @doc false
  def changeset(credential, attrs) do
    credential
    |> cast(attrs, [:password, :email])
    |> validate_required([:email, :password])
    |> validate_length(:password, min: 6, max: 100)
    |> validate_confirmation(:password, message: "does not match password")
    |> unique_constraint(:email)
    |> put_pass_hash()
  end

  def put_pass_hash(credential) do
    case credential do
      %Ecto.Changeset{valid?: true, changes: %{password: pass}} ->
        put_change(credential, :password_hash, Comeonin.Bcrypt.hashpwsalt(pass))
      _ ->
        credential
    end
  end
end
