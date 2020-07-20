defmodule Deusexlog.UserManager do
  @moduledoc """
  The UserManager context.
  """

  import Ecto.Query, warn: false
  alias Deusexlog.Repo
  alias Deusexlog.UserManager.User

  @doc """
  Returns the list of users.

  ## Examples

      iex> list_users()
      [%User{}, ...]

  """
  def list_users do
    Repo.all(User)
  end

  @doc """
  Gets a single user.

  Raises `Ecto.NoResultsError` if the User does not exist.

  ## Examples

      iex> get_user!(123)
      %User{}

      iex> get_user!(456)
      ** (Ecto.NoResultsError)

  """
  def get_user!(id), do: Repo.get!(User, id)

  @doc """
  Gets a single user.

  Raises `Ecto.NoResultsError` if the User does not exist.

  ## Examples

      iex> get_user_by_name!("username")
      %User{}

      iex> get_user_by_name!("non-username")
      ** (Ecto.NoResultsError)

  """
  def get_user_by_name!(name), do: Repo.get_by!(User, username: name)

    @doc """
  Gets a single user.

  Raises `Ecto.NoResultsError` if the User does not exist.

  ## Examples

      iex> get_user_by_name!("username")
      %User{}

      iex> get_user_by_name!("non-username")
      ** (Ecto.NoResultsError)

  """
  def get_user_by_email!(name), do: Repo.get_by!(User, email: name)

  @doc """
  Creates a user.

  ## Examples

      iex> create_user(%{field: value})
      {:ok, %User{}}

      iex> create_user(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_user(attrs \\ %{}) do
    %User{}
    |> User.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a user.

  ## Examples

      iex> update_user(user, %{field: new_value})
      {:ok, %User{}}

      iex> update_user(user, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_user(%User{} = user, attrs) do
    user
    |> User.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a user.

  ## Examples

      iex> delete_user(user)
      {:ok, %User{}}

      iex> delete_user(user)
      {:error, %Ecto.Changeset{}}

  """
  def delete_user(%User{} = user) do
    Repo.delete(user)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking user changes.

  ## Examples

      iex> change_user(user)
      %Ecto.Changeset{source: %User{}}

  """
  def change_user(%User{} = user) do
    User.changeset(user, %{})
  end

  import Ecto.Query, only: [from: 2]
  require Logger

  def authenticate_user(email, plain_text_password) do
    timestamp = DateTime.utc_now()

    Logger.info "#{timestamp}: Login atempt by #{email}"
    user = Repo.get_by(User, email: email)
    case user do
      nil ->
        Logger.info "#{timestamp}: #{email} not found"
        {:error, :invalid_credentials}
      user ->
        Logger.info "#{timestamp}: #{email} found"
        if user.password == plain_text_password do
          Logger.info "#{timestamp}: #{email} password correct"
          {:ok, user}
        else
          Logger.info "#{timestamp}: #{email} bad password"
          {:error, :invalid_credentials}
      end
    end
  end
end
