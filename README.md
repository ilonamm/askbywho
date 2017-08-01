[![CircleCI](https://circleci.com/gh/ilonamm/askbywho.svg?style=svg)](https://circleci.com/gh/ilonamm/askbywho)

# askbywho.com

Welcome to the askbywho.com service.  This is the source code that runs at askbywho.com, and changes here (to master) will be pushed to the prod service.

Read more about our [mission](mission.md).


## Getting started

### Technical set up
 
Repository in Github: https://github.com/ilonamm/askbywho
You’ll be happy to know the project is open source!
 
We like to follow per issue branching, with master being the pristine copy. Feel free to add issues on GitHub for each feature / Trello task. We don't really have too many rules but minimum, we want that, PRs into master and unit tests. When naming branches, use yourname-featurename, for example ilona-herokusetup. When changes have been merged, delete the branch.
 
### Coordinating the work

#### Kanban & Trello

To plan and coordinate our work, we’re using Kanban-inspired system in Trello. Kanban is fairly popular in many software development projects. 
 
If you’re not familiar with Kanban, here is a simple article explaining the thinking behind Kanban: https://www.sitepoint.com/how-why-to-use-the-kanban-methodology-for-software-development/
 
You can join the Trello board for development with this link: https://trello.com/invite/b/lUaYwCg9/42ec2cefbb100e9c64e8829b152beb44/ask-by-who
 
When you start developing a task, just drag it in the “doing” part. That way we can always stay easily up-to-date who is working on what and what’s already done.

#### Review task 

Before starting development, review the task. Is it clear for you what to do? Does it make sense to you? Would it make sense to you to do it in some other way? Do you have a good idea to add? If there’s anything unclear or something you could improve, mark the card with red 'pending' label and make a comment. 
 
#### Estimate workload 

Think of an estimate how many hours it will take you to do the task. It is a common practice to estimate the workload, yet it is often really tricky. Just make a guess! If it takes much longer than one full working day, please split the task up.
 
Add your estimate as a comment. Then after you’re done the development, update it with approximately how long it took you. Just be honest. The point is to learn about workload estimation and help with overall planning.
 
When you start the development, please drag the Trello card to ‘doing’. And when you’re done, drag it to the code review.




## Local Setup

To start your Phoenix app:

  * Install dependencies with `mix deps.get`
  * Create and migrate your database with `mix ecto.create && mix ecto.migrate`
  * Install Node.js dependencies with `npm install`
  * Start Phoenix endpoint with `mix phoenix.server`

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.

Ready to run in production? Please [check our deployment guides](http://www.phoenixframework.org/docs/deployment).

## Learn more

  * Official website: http://www.phoenixframework.org/
  * Guides: http://phoenixframework.org/docs/overview
  * Docs: http://hexdocs.pm/phoenix
  * Mailing list: http://groups.google.com/group/phoenix-talk
  * Source: https://github.com/phoenixframework/phoenix
