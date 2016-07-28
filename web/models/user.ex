defmodule Pxblog.User do
  use Pxblog.Web, :model

  import Comeonin.Bcrypt, only: [hashpwsalt: 1]

  schema "users" do
    has_many :posts, Pxblog.Post
    belongs_to :role, Pxblog.Role

    field :username, :string
    field :email, :string
    field :password_digest, :string

    timestamps()

    # Virtual Fields
    field :password, :string, virtual: true
    field :password_confirmation, :string, virtual: true
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:username, :email, :password, :password_confirmation])
    |> validate_required([:username, :email, :password, :password_confirmation])
    |> hash_password
  end

  defp hash_password(changeset) do
    case get_change(changeset, :password) do 
      nil -> changeset
      password -> changeset |> put_change(:password_digest, hashpwsalt(password))
    end
  end
end
