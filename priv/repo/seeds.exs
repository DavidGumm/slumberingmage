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

# permissions
# ["admin","post","comment", ""]

Slumberingmage.UserManager.create_user(%{
  username: "Underlord",
  password: "password",
  email: "admin",
  access: ["admin", "post", "comment"],
  image: "face.png",
  bio: "🜏"
})

Slumberingmage.UserManager.create_user(%{
  username: "David Gumm",
  password: "password",
  email: "gumm.david@gmail.com",
  access: ["admin", "post", "comment"],
  image: "face.png",
  bio:
    "My first computer was a Commodore 64 and it was my grandfather that taught me how to use it. He used to make Mad Libs programs for me so that I could learn to read. I tried and built some simple Mad Libs programs back then. Ever since 1984  I have been on and using computers. After the Commodore 64 my parents bought an x86 Gateway in 1992, and in 1994 I got my first computer, a self built 486. I tried to teach myself the basic programming language but never did anything with it. Fast forward to 2012 and I got my first IT job as a Help Desk Technician/Network Admin. I did it all from A to Z, help desk, network configuration website design and consulting. I learned a lot from that experience. After that I ended up getting into powershell scripting and that led to my first programming job. Where I became a full stack developer using:
  .NET Framework
  C#
  Microsoft SQL Server
  JavaScript
  HTML
  CSS"
})

require Logger
user = Slumberingmage.UserManager.get_user_by_email!("gumm.david@gmail.com")
Logger.debug("Found user #{user.username}, id: #{user.id}")

posts = [
  %{
    slug: "intro",
    title: "Introduction",
    tags: ["new", "elixir", "intro"],
    body:
      "I started to learn Elixir both to further my career and skills as an IT professional/Full Stack Developer. C# is a powerful and robust language but felt like I needed to get more breath of experience so as not to be pinned down to one technology stack. I have known for a long time that I needed to build a professional page to show off my skills to post my experiences and what I have learned to blogs and online in general. So I have stated a new project just for that. This blog is built on Elixir and the Phoenix framework.",
    published: true,
    cover: "holder.png",
    views: 0,
    user_id: user.id
  },
  %{
    slug: "from-c-sharp-to-elixir",
    title: "From c# to Elixir",
    tags: ["c#", "elixir", "phoenix"],
    body:
      "Learning Elixir as a c# Developer has been an eye opener.
    First, I did not realize just how much I relied on Visual Studio and Intellisense for just simple tasks.
    Second, learning new naming conventions is hard.
    Third, Struggling with learning a new programming language and how people think about it is difficult in a whole different way.

    Elixir has been around since 2011 and is built on Erlang which has been around since 1986. It’s odd for me to read that because I got my first IT job in 2012 so it's only been a thing for one more year then I have been an IT professional.

    I have been using Visual Studio Code for a while and added in everything I can to get me up and running for Elixir development, I’ll provide a list of plugins I use at the end of the post. I find that Intellisense while it works and is there for other languages it really works best just for .NET. I’m not sure if it's just something to do with the way Microsoft built .NET or that other languages don’t really have the same kind of baked in support for it. It’s really been a struggle for me to find what I am trying to find simple commands, some of that's just having learned the name spaces for .NET and JavaScript functions some from not having a robust fast Intellisense experience.",
    published: true,
    cover: "holder.png",
    views: 0,
    user_id: user.id
  }
]

Logger.debug("")
Logger.debug("")
Logger.debug("")

Enum.each(posts, fn post ->
  Slumberingmage.Posts.create_post!(post)
  Logger.debug("Creating post")
end)

Logger.debug("")
Logger.debug("")
Logger.debug("")

new_posts = Slumberingmage.Posts.list_posts()

for new_post <- new_posts do
  Logger.debug("Created post #{new_post.id}")
end

Logger.debug("")
Logger.debug("")
Logger.debug("")
