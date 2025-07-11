ActiveRecord::Base.connection.reset_pk_sequence!("users")
ActiveRecord::Base.connection.reset_pk_sequence!("projects")
ActiveRecord::Base.connection.reset_pk_sequence!("activities")

first_user = User.create(name: "Dummy Persona 1", color: 'green')
second_user = User.create(name: "Dummy Persona 2")

first_project = Project.create(name: "Pineapple on pizza!",
                               status: "active",
                               description: "Is this the not the best thing ever?!")
second_project = Project.create(name: "Pizza on pineapple!!!",
                               description: "The next level gastonomy experience")

Comment.create(content: { text: "Ewww" },
               activitable_type: "Project",
               activitable: first_project,
               user: first_user)

Comment.create(content: { text: "Now that sounds interesting" },
               activitable_type: "Project",
               activitable: second_project,
               user: first_user)

Comment.create(content: { text: "Nothing wrong with that" },
               activitable_type: "Project",
               activitable: first_project,
               user: second_user)

Comment.create(content: { text: "What?" },
               activitable_type: "Project",
               activitable: second_project,
               user: second_user)

Comment.create(content: { text: "Is this for real?" },
               activitable_type: "Project",
               activitable: second_project,
               user: second_user)
