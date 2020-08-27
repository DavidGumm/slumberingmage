defmodule Deusexlog.UserManager do
  @moduledoc """
  The UserManager context.
  """

  import Ecto.Query, warn: false
  import Ecto.Query, only: [from: 2]
  alias Deusexlog.{Repo, UserManager.User}

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
  def create_user!(attrs \\ %{}) do
    %User{}
    |> User.changeset(attrs)
    |> Repo.insert!()
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

  @doc """
  Returns an truple for verifying user password.
  Either {:ok, user} or {:error, :invalid_credentials}

  ## Examples

      iex> authenticate_user(user)
      %{source: %{:ok, user}}

  """
  @spec authenticate_user(String.t(), String.t()) :: map()
  def authenticate_user(email, password) do
    user = Deusexlog.UserManager.get_user_by_email!(email)
    authenticate(user, password)
  end
require Logger
  defp authenticate(%User{} = user, password) do
    if(user.password == password) do
      Deusexlog.UserManager.update_user(user, %{:password => user.password})
      authenticate(Deusexlog.UserManager.get_user_by_email!(user.email), password)
    else
    authenticate(
      user,
      password,
      Bcrypt.verify_pass(password, user.password)
    )
    end
  end

  defp authenticate(nil, password) do
    authenticate(nil, password, Bcrypt.no_user_verify())
  end

  defp authenticate(%User{} = user, _password, true) do
    {:ok, user}
  end

  defp authenticate(_user, _password, false) do
    {:error, "Access is denied due to invalid credentials."}
  end

  defp authenticate(_user, _password, error) do
    {:error, "Access is denied due to invalid credentials."}
  end
end
