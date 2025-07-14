# Project Comment Component

## How to run
- Create the database with `bundle exec rails db:create`
- Migrate it with `bundle exec rails db:migrate`
- Run `bin/dev` to run foreman (Run Tailwind builder and Rails in the same daemon)

## Testing
- `bundle exec rspec` or `RAILS_ENV=test bundle exec rake rspec_watcher:watch`

## Caveats
This code is supposed to be easily reviewed and was created without Rails boilerplate (using `--minimal`), therefore if this was to be a serious application we'd need [improvements](#improvements)


## Possible questions
- Q: Should User deletion Cascade delete activities (like comments)?
  - A: Yes, same for Projects and their activities
- Q: Where should we use Turbo frames?
  - A: Let's use them together with Action Cable so that updates come in realtime. We can also change the elements that are updated dinamically (e.g. Project status)
- Q: What could we use for Auth?
  - A: Devise or Pundit
- Q: What if we are interested in more than just the `name` and `status` change for projects?
  - A: We can simply change `ProjectsController::CREATE_ACTIVITY_ON_CHANGE` or even install `papertrail`
- Q: How do we see the soft deleted records?
  - A: We don't have an admin dashboard of sorts so we can only see them using `unscope` in the `rails console`
- Q: Why is Activity polymorphic?
  - A: We can make activities in all sorts of models with this approach. I think the next step would be to have an Epic, or Initiative or something similar to the already existing Project. :)

## Improvements
- Restate modern Rails security guidelines
  - e.g. having `config/initializers/content_security_policy.rb`
- Improve accessibility/usage with i18n/locale support
- Use Rails awesome PWA support (Improved for Rails 8)
- Use [https://brakemanscanner.org/]
- Actual user registration/login
  - User owned projects that only they can edit
  - Allow user to change their "color" or image
- Add an admin user that can delete any comment
- There's no way of editing the Comments currently
- UUID for models
  - The users seeing the `/:id` at the end of routes is not so great
- Add Turbo and Stimulus (already installed, so we are only using the progress bar)
- Add a footer/header
- StatusUpdateCreator for project changes is still a bit messy
- Seeds are placeholders
- Create a Hash that has `diff` (deprecated in the past so the function that does this looks weird)
- Improve logging (.log is insufficient). I'd suggest a third party service like Rollbar or even Newrelic (plays nicely with Heroku!)
- Improve Rubocop rules, it's currently using the most basic set
- Integration tests and missing tests
  - Test concern
  - Use shared examples for soft deletables
- There's an ambiguous spec error when running in the current ruby versions. This started when we added `foreman`
```
  - WARN: Unresolved or ambiguous specs during Gem::Specification.reset:
        stringio (>= 0)
        Available/installed versions of this gem:
        - 3.1.7
        - 3.1.2
        - 3.1.1
        - 3.1.0
```


### Credits

- Tailwind Components from https://flowbite.com/
  - https://flowbite.com/docs/components/timeline/
- SVGs from https://fontawesomeicons.com/svg/icons

#### Disclaimer
This project was written without any AI assistance. Instead, to write it faster, I leaned heavily on Rails Generators and Scaffolds
