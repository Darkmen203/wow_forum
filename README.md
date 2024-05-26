The setups steps expect following tools installed on the system.

- Github
- Ruby [3.3.1]
- Rails [7.1.3.3]

##### 1. Check out the repository

```bash
git clone https://github.com/Darkmen203/wow_forum.git  
```

##### 2. Prepare to work

Run the following commands to setup project.

```ruby
bundle install
rails tailwindcss:build
```


##### 3. Create and setup the database

Run the following commands to create and setup the database.

```ruby
rails db:create
rails db:migrate
rails db:seed
```

##### 4. Run tests

Run the following commands to start tests.

```ruby
rails db:schema:load
rails test
```

##### 5. Start the Rails server

You can start the rails server using the command given below.

```ruby
rails server
```

And now you can visit the site with the URL http://localhost:3000
