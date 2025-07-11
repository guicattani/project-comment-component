## Project Comment Component

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
- UUID for models
  - The users seeing the `/:id` at the end of routes is not so great
- Add Turbo and Stimulus (already installed, so we are only using the progress bar)
- Add a footer/header
- ActivityCreator for project changes is still a bit messy
- Seeds are placeholders
- Create a Hash that has `diff` (deprecated in the past so the function that does this looks weird)
- Improve logging (.log is insufficient). I'd suggest a third party service like Rollbar or even Newrelic (plays nicely with Heroku!)

### Credits

- Tailwind Components from https://flowbite.com/
  - https://flowbite.com/docs/components/timeline/
- SVGs from https://fontawesomeicons.com/svg/icons

#### Disclaimer
This project was written without any AI assistance. Instead, to write it faster, I leaned heavily on Rails Generators and Scaffolds
