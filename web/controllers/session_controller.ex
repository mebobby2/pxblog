defmodule Pxblog.SessionController do
  use Pxblog.Web, :controller

  alias Pxblog.User

  import Comeonin.Bcrypt, only: [checkpw: 2]

  plug :scrub_params, "user", when action in [:create]

  def new(conn, _params) do
    render conn, "new.html", changeset: User.changeset(%User{})
  end
end