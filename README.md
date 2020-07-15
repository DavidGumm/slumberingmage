Table of Contents
- [Links](#links)
- [Tasks](#tasks)
  - [Refs](#refs)

# Links

* [http://localhost:4000](http://localhost:4000)
* [Elixir Libhunt](https://elixir.libhunt.com/)
* [Guardian](https://hexdocs.pm/guardian/tutorial-start.html)
* [Cloak](https://hexdocs.pm/cloak/1.0.2/install.html#content)
* [Cloak ecto](https://hexdocs.pm/cloak_ecto/1.0.1/install.html#content)
* [Phoenix ecto](https://hexdocs.pm/phoenix/ecto.html#content)
* [Earmark](https://hexdocs.pm/earmark/Earmark.html)

# Tasks

- [ ] Build router tests
- [ ] Finish integrating [Guardian](https://hexdocs.pm/guardian/tutorial-start.html)
- [ ] Integrate Ueberauth, using Google, Reddit, FB, Linkedin, Twitter
- [ ] Eliminate passwords in database
- [x] Test and verify [Earmark](https://hexdocs.pm/earmark/Earmark.html)
  - Earmark not parsing task list/does not support them. [Read more](https://github.com/pragdave/earmark/issues/126)
- [ ] Create search bot at add links to pages.
- [ ] Maybe Convert to umbrella app using JSON backend and Vue for the front end.
- [ ] Fix issue with website restart and cookie not getting recycled.
  - Not seeing a max age or expiration date on the cookie. Need to find a way to force the cookie to go away. This seems to stem from Plug.
  - Updated Plug to latest version, need to see if the issue is still happening.
- [ ] Rename application to "new name".


## Refs

  * [building-a-web-framework-from-scratch-in-elixir](https://codewords.recurse.com/issues/five/building-a-web-framework-from-scratch-in-elixir)
  * [Authentication in Elixir Web Applications with Ueberauth and Guardian: Part 1](https://thoughtbot.com/blog/authentication-in-elixir-web-applications-with-guardian-part-1)
  * [Authentication in Elixir Web Applications with Ueberauth and Guardian: Part 2](https://thoughtbot.com/blog/authentication-in-elixir-web-applications-with-guardian-part-2)
  * [Authentication in Elixir Web Applications with Ueberauth and Guardian: Part 3](https://thoughtbot.com/blog/authentication-in-elixir-web-applications-with-guardian-part-3)
  * [Authentication in Elixir Web Applications with Ueberauth and Guardian: Part 4](https://thoughtbot.com/blog/authentication-in-elixir-web-applications-with-ueberauth-and-guardian-part-4)
