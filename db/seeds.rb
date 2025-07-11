ActiveRecord::Base.connection.reset_pk_sequence!("users")
ActiveRecord::Base.connection.reset_pk_sequence!("projects")
ActiveRecord::Base.connection.reset_pk_sequence!("activities")

User.create(name: "Dummy Persona 1")
User.create(name: "Dummy Persona 2")

Project.create(name: "Example Project 1", description: "Pineapple on pizza")
Project.create(name: "Example Project 2", description: "Pizza on pineapple")

Comment.create(content: "Ewww",
               activitable_type: "Project",
               activitable: Project.find_by(name: "Example Project 1"),
               user: User.find_by(name: "Dummy Persona 1"))

Comment.create(content: "Now that sounds interesting",
               activitable_type: "Project",
               activitable: Project.find_by(name: "Example Project 2"),
               user: User.find_by(name: "Dummy Persona 1"))

Comment.create(content: "Nothing wrong with that",
               activitable_type: "Project",
               activitable: Project.find_by(name: "Example Project 1"),
               user: User.find_by(name: "Dummy Persona 2"))

Comment.create(content: "What?",
               activitable_type: "Project",
               activitable: Project.find_by(name: "Example Project 2"),
               user: User.find_by(name: "Dummy Persona 2"))

Comment.create(content: "Is this for real?",
               activitable_type: "Project",
               activitable: Project.find_by(name: "Example Project 2"),
               user: User.find_by(name: "Dummy Persona 2"))
