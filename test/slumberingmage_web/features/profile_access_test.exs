defmodule SlumberingmageWeb.ProfileAccessTest do
  use SlumberingmageWeb.FeatureCase, async: true

  test "Accessing a protected resource without logging in", %{session: session} do
    visit(session, "/profile")

    assert current_path(session) == "/login"
  end
end
