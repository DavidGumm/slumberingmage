# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     Deusexlog.Repo.insert!(%Deusexlog.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

# permissions
# ["admin","post","comment", ""]

Deusexlog.UserManager.create_user(%{
  username: "Underlord",
  password: "password",
  email: "admin",
  access: "admin",
  image: "face.png",
  bio: "🜏"
})

Deusexlog.UserManager.create_user(%{
  username: "David Gumm",
  password: "password",
  email: "gumm.david@gmail.com",
  access: "admin",
  image: "face.png",
  bio: "<p>My first computer was a Commodore 64 and it was my grandfather that taught me how to use it. He used to make Mad Libs programs for me so that I could learn to read. I tried and built some simple Mad Libs programs back then. Ever since 1984 I have been on and using computers. After the Commodore 64 my parents bought an x86 Gateway in 1992, and in 1994 I got my first computer, a self built 486. I tried to teach myself the basic programming language but never did anything with it. Fast forward to 2012 and I got my first IT job as a Help Desk Technician/Network Admin. I did it all from A to Z, help desk, network configuration website design and consulting. I learned a lot from that experience. After that I ended up getting into PowerShell scripting and that led to my first programming job. Where I became a full stack developer using:</p><ul><li>.NET Framework</li><li>C#</li><li>Microsoft SQL Server</li><li>JavaScript</li><li>HTML</li><li>CSS</li></ul>"
})

require Logger
user = Deusexlog.UserManager.get_user_by_email!("gumm.david@gmail.com")
Logger.debug("Found user #{user.username}, id: #{user.id}")

posts = [
  %{
    slug: "intro",
    title: "Introduction",
    tags: ["new", "elixir", "intro"],
    summary: "Introduction to the blog and what I am trying to do.",
    body: "I started to learn Elixir both to further my career and skills as an IT professional/Full Stack Developer. C# is a powerful and robust language but felt like I needed to get more breath of experience so as not to be pinned down to one technology stack. I have known for a long time that I needed to build a professional page to show off my skills to post my experiences and what I have learned to blogs and online in general. So I have stated a new project just for that. This blog is built on Elixir and the Phoenix framework.",
    published: true,
    publish_date: "2020-07-07",
    cover: "https://i.picsum.photos/id/170/1200/300.jpg?hmac=qYQfC2ugH6KSe15XzjvltOomGJhvi1_rkdZP6G_haFY",
    views: 0,
    user_id: 2
  },
  %{
    slug: "from-c-sharp-to-elixir",
    title: "From c# to Elixir",
    tags: ["c#", "elixir", "phoenix"],
    summary: "Learning Elixir as a .NET Developer. Building this blogging site, and the tech stack to do it.",
    body: "Learning Elixir as a c# Developer has been difficult and rewarding.",
    published: true,
    publish_date: "2020-07-16",
    cover: "https://i.picsum.photos/id/410/1200/300.jpg?hmac=2JQKCsjToD1kSC7AnZESlInV1Hjey0rzGJ-q7wjO2E4",
    views: 0,
    user_id: 2
  }
]

Logger.debug("")
Logger.debug("")
Logger.debug("")

Enum.each(posts, fn post ->
  Deusexlog.Posts.create_post!(post)
  Logger.debug("Creating post")
end)

Logger.debug("")
Logger.debug("")
Logger.debug("")

new_posts = Deusexlog.Posts.list_posts()

for new_post <- new_posts do
  Logger.debug("Created post #{new_post.id} user #{new_post.user_id}")
end

Logger.debug("")
Logger.debug("")
Logger.debug("")
