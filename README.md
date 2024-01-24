# URL Shortener Project

## Overview

This project is a URL shortener that allows users to input a URL and receive a shortened version of it. The system will redirect users to the original URL when they enter the short URL. Additionally, the project includes features such as displaying the top 100 most frequently accessed URLs and asynchronously storing the title of the website.

## Versions
- Ruby: 3.3.0
- Rails: 7.1.3
- MySQL: 8.2.0
- Redis: 7.2.4

## Prerequisites

Before setting up the project, make sure you have the following prerequisites installed on your system:

1. **Homebrew:**
   - Install Homebrew: [Homebrew Installation](https://brew.sh/)
   ```bash
   /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

2. **MySQL:**
   - Install MySQL: `brew install mysql`
   - Start MySQL service: `brew services start mysql`
   - Create a user and set privileges:
   ```bash
   mysql -u root -p
   CREATE USER 'shorteneruser'@'localhost' IDENTIFIED WITH mysql_native_password BY 'your_password';
   GRANT ALL PRIVILEGES ON *.* TO 'shorteneruser'@'localhost';
   FLUSH PRIVILEGES;
   ```

3. **Redis:**
   - Install Redis: `brew install redis`

4. **Ruby on Rails with RVM:**
   - Install RVM: [RVM Installation](https://rvm.io/rvm/install)
   ```bash
   \curl -sSL https://get.rvm.io | bash -s stable --ruby
   gem install rails
   ```

## Project Setup

1. **Clone the repository:**
  ```bash
  git clone https://github.com/<your_username>/url-shortener.git
  cd url-shortener
  ```
   
2. **Install dependencies:**
  ```bash
  bundle install
  ```

3. **Database setup:**
  ```bash
  rails db:create
  rails db:migrate
  ```

4. **Run the application:**
In your terminal, open 3 tabs to run one command per tab
  ```bash
  redis-server
  sidekiq
  rails s
  ```

## Running Tests
To run RSpec tests for the project, use the following command:
```bash
bundle exec rspec spec
```

## Usage
Access the home page at http://localhost:3000.  
Input a URL to receive a shortened version.  
Use the short URL to be redirected to the original URL. Ex: The shortened url is `r3d`. http://localhost:3000/r3d will redirect you to the original url.  
View the top 100 most frequently accessed URLs at http://localhost:3000/top-100. 

## Asynchronous Processing
After creating a short URL, an asynchronous process (Sidekiq) will pull the title from the website. Please refresh the page to check the recently added titles.

## Url Shortener Algorithm
The algorithm is:
```ruby
ALPHABET = 'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789'.chars
def generate_short_url!
 index = id
 new_url = ''
 base = ALPHABET.length

 while index.positive?
   new_url << ALPHABET[index.modulo(base)]
   index /= base
 end
 update(short_url: new_url)
end
```
For this algorithm we will need to use an unique identifier. Since the database IDs are unique we will use them.  
Then having the ID will be as easy as converting it form a decimal system to a base-62 number. We use a base-62 since is the number of characters at the `ALPHABET` constant.  
The converting part is done by the `while` instruction.  
Then we save the result convertion into the `short_url` column.  
The time complexity is `O(log n)`, where `n` is the ID. This gives us one of the best notations we can have.

## Notes
This project uses Sidekiq and Redis for handling asynchronous jobs.
To flush Redis database, use the following command:
```bash
redis-cli
FLUSHALL
```
