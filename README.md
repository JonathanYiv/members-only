# Members-Only Project

The goal of this project is to implement a members only 'clubhouse' using Rails.

Normal users can view anonymously authored posts.

Users who are members can write posts and see the authors of posts.

This is a project from [The Odin Project](https://www.theodinproject.com/courses/ruby-on-rails/lessons/authentication).

Screenshot here...

## Pre-Project Thoughts

For Odin's Rail Curriculum so far, there hasn't been a huge amount of independent work.

A lot of the Rails section was following Michael Hartl's [Rails Tutorial](https://www.railstutorial.org).

I am hoping I absorbed enough knowledge to put it into practice and develop my skills accordingly.

### Structure

There will be a Users resource, with all seven of the RESTful routes.
	The attributes will be email, username, and password_digest.

There will be a Sessions resource, without a Active Record model, with the :new, :create, and :destroy routes.

There will be a Posts resource, with all seven of the RESTful routes.

Posts will belong to Users. Users will have many Posts.
	The attributes will be content and user_id.

## Post-Project Thoughts

Incomplete..
