Keeping track of your day-to-day tasks can be daunting and tiring. Your task is to create an application that allows users to keep track of their tasks easily.

Minimum Viable Product
The following features must be completed in order to consider your submission as valid:
Users should be able to register / login to the platform
A user should be able to create a task that is well described with due dates.
A user should be able to update the status of their task.
A user should be able to view information about a single task.
A user should be able to list all their tasks for the day.
A user should be able to filter tasks by completion status and/or due dates.
In order to use the application, the user must be logged in.


Herein lies the plan to complete the project.

Front-End
          Users should visually interact with the following processes:
             1. Register  for the application:
                 Collect data (first name, last name, email address, age, gender, productivity)
             2. Login to the application (Only authenticated users can use the app):
                 Sign into the app using a username/email & password
             3. Create a task, describe the task, add due dates for the task, add status(complete or incomplete) & add collaborators.
                 Add a page that allows the user to add a new task.
                 The page should request the following information:
                      1. The title of the task.
                      2. The description of the task.
                      3. The date the task is due.
                      4. The status of the tast. There are two functional statuses for each task:
                         (Complete, Incomplete)
                      5. Add collaborator's emails addresses to patch an invite to them.
             4. Preview each task with the relevant information:
                 Display each task in it's own page, display the following data:
                      1. The title  of the task.
                      2. A description of the task.
                      3. The date the task was created.
                      4. The date the task is due.
                      5. A list of all included collaborators.


             5. List all tasks based on the day of the task:
             6. Filter tasks based on their completion status:
             7. Filter tasks based on the due date:

Back-End
          The front end should interact with server-side for the following processes:
             1. Validate