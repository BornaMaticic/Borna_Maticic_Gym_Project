# Gym-Management-Project

## Introduction:


Created for the week 5 solo project of Codeclan (Cohort E26), this program allows for the adding, editing and deleting members in a gym.
## To Run:

### Create appropriate db

In your terminal, create a DB called 'gym' to store the date

### Run main file

Simply clone the directory and run the app.rb file in your Ruby interpreter.

## Required:

* Sinatra Gem
* PG Gem 

## Recommended:

* Pry gem to run the seeds file (not strictly required; can add info in the project itself)

# Project - Web Programming with Ruby

Over the next week you will build an app to consolidate and expand on everything you have learned:

* Object oriented programming with Ruby
* Test Driven Development
* Web Programming (REST, MVC)
* Interacting with a PostgreSQL database (CRUD)

## Rules

The project must be built using only:

* HTML / CSS
* Ruby
* Sinatra
* PostgreSQL and the PG gem

It must **NOT** use:

* Any Object Relational Mapper (e.g. ActiveRecord)
* JavaScript. At all. Don't even think about it.
* Any pre-built CSS libraries, such as Bootstrap.
* Authentication. Assume that the user already has secure access to the app.


###Briefs 

### Gym

A local gym has asked you to build a piece of software to help them to manage memberships, and register members for classes.

#### MVP

- The app should allow the gym to create / edit / delete members
- The app should allow the gym to create / edit / delete classes
- The app should allow the gym to add members to specific classes
- The app should show a list of all upcoming classes
- The app should show all members that are registered for a particular class 


#### Possible Extensions

- Classes could have a maximum capacity, and users can only be added while there is space remaining.
- The gym could be able to give its members Premium or Standard membership. Standard members can only be signed up for classes during off-peak hours.
