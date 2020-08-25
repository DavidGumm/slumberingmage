defmodule Deusexlog.Accounts do
  alias Deusexlog.Repo
  alias __MODULE__.User

  def register(%Ueberauth.Auth{} = params) do
    %User{}
    |> User.changeset(extract_account_params(params))
    |> Deusexlog.Repo.insert()
  end

  defp extract_account_params(%{credentials: %{other: other}, info: info}) do
    info
    |> Map.from_struct()
    |> Map.merge(other)
  end
end

# defmodule Deusexlog.Accounts do
#   @moduledoc """
#   The Accounts context.
#   """

#   import Ecto.Query, warn: false
#   alias Deusexlog.Repo

#   alias Deusexlog.Users.User

#   @doc """
#   Gets a single user.

#   Raises `Ecto.NoResultsError` if the User does not exist.

#   ## Examples

#       iex> get_user!(123)
#       %User{}

#       iex> get_user!(456)
#       ** (Ecto.NoResultsError)

#   """
#   def get_user!(id), do: Repo.get!(User, id)

#   @doc """
#   Updates a user.

#   ## Examples

#       iex> update_user(user, %{field: new_value})
#       {:ok, %User{}}

#       iex> update_user(user, %{field: bad_value})
#       {:error, %Ecto.Changeset{}}

#   """
#   def update_user(%User{} = user, attrs) do
#     user
#     |> User.changeset(attrs)
#     |> Repo.update()
#   end

#   @doc """
#   Returns an `%Ecto.Changeset{}` for tracking user changes.

#   ## Examples

#       iex> change_user(user)
#       %Ecto.Changeset{source: %User{}}

#   """
#   def change_user(%User{} = user) do
#     User.changeset(user, %{})
#   end
# end
