# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     Slumberingmage.Repo.insert!(%Slumberingmage.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

Slumberingmage.UserManager.create_user(%{username: "David Gumm", password: "password", email: "gumm.david@gmail.com", access: "admin,poster,commenter", image: "face.png", bio: "string"})
