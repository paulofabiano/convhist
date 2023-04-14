# README

This is a tech test for my application to Homey.

## Task

Use Ruby on Rails to build a project conversation history. A user should be able to:

* leave a comment
* change the status of the project

The project conversation history should list comments and changes in status.

## Acceptance Criteria

Those are the criteria known so far:

* leave a comment
* change the status of the project

But these are to vague and would be necessary to go deeper and understand better the requirements.

Here are some more questions that would help:

1. Which projects users can comment? Its own for anyone?
2. The status should follow some predefined sequence or is it free to change from any status to any other?
3. What are the statuses expected for a project?
4. How to manage authentication/Authorization?
5. What's the access volume expected for this app? Which points we need to implement a cache?
6. How are we monitoring this?


## Context

For the sake of this tech test and its limited duration, I made some tough decisions and, if I had more time, I could make things differently:

1. Using Sqlite3 DB. It is just right to go and not lose time.
2. Minimum effort for UX/UI. Tailwind is setup for the very basic but this is going to be ugly.
3. Using hotwire (turbo frame, turbo stream and stimulus) for building some SPA for projects and comments CRUD
4. Skipping tests with RSpec (Sorry)
5. Letting refactoring for later: extracting code into services, scopes, etc.
6. Just organize git commits in the end.
7. No paginations for now.

## Acceptance Criteria 

This is the final version of the acceptance criteria I decided to use for building the application, along with the context information listed below:

1. Which projects users can comment? Its own for anyone?
Answer: Users can comment in any project but they need to be logged-in.

2. The status should follow some predefined sequence or is it free to change from any status to any other?
Answer: There is not predefined sequence. You can change it freely. 

3. What are the statuses expected for a project?
Answer: The statuses defined are: Draft, Published, Archived and Trashed.

4. How to manage authentication/Authorization?
Answer: I decided to use Clearance because it is simpler and faster to implement than Devise. 
No authorization is necessary.

5. What's the access volume expected for this app? Which points we need to implement a cache?
Answer: Unknown for now. I'd start monitoring the app in order to detect some bottleneck and decide the caching strategy later. So, nothing to do right now.

6. How are we monitoring this?
Answer: Nothing for now. This depends the tools available from the company. Datadog would be a nice option.

## Data model

Basically I am using 3 models: User, Project and Comment. A project belongs to user and has many comments. A comment belongs to user and to project.
The solution for listing comments and status changes in the same list chronologically was creating a custom comment right after a status change is commited in the DB. The body of the comment has a custom message informing someone changed from status X to Y.

## Improvements

Those are the things I'd do if I had more time:

1. Using dockerfile and docker compose to setup development environment.
2. Implement specs
3. Extract some business logic into services
4. Refactoring controllers, they are still messy
5. Improve UI/UX
6. Improve notification system for flash messages
7. Setup rubocop
8. Create make files for running server, tests, rubocop, ci, and other commands in bin folder
9. Working with ViewComponents instead rendering partials (more organized frontend code)
10. Using polymorphism and making project and other future resource commentable. 