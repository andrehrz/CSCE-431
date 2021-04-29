#CSCE-431-Instructor_Turnover

Executing the code:

- Navigate to a new folder in any location on your computer with command line.
- Connect to source code in the git repository using "git remote add origin <remote repository URL>".
- Switch to the master branch of the code.
- Download the master branch of the git repository using git pull.
- Make sure your command line is in the root of the project.
- In PG ADMIN create two databases, one for testing and one for development.
- Change the database names in the database.yml in the config folder of the project to your testing and development database.
- *Make sure to also change your username and password in this file to your postgres username and password*
- Run rails db:migrate in the terminal
- Run "rails server" and navigate to "http://localhost:3000/" inside GOOGLE CHROME (our only supported browser).
- The application should now be running.

Deploy the code in Heroku:
- Create a new app in heroku after you sign in.
- Go the the new app settings and go to the deploy tab.
- Change the deplyoment method to github.
- Choose the respository with the source code from github.
- Under manual deploy, click main branch, and hit "deploy" to deply the app.

Summary of how we did it:

Sprint 1: 
- We used the command line to deploy our code to heroku in the first sprint. 
- First we created an app and logged into heroku via the command line. 
- Next we had to make sure that a database was connected to the app in heroku by using a rake command. 
- Finally, the code was pushed to Heroku where it was built and deployed.

Sprint 2&3: 
- In the second two sprints we used a heroku pipeline to deploy our code to heroku. 
- By connecting our github repository, we were able to build apps directly from the different branches we were pushing up to our repository and bypassing the command line interface completely. 
- We made use of the review apps to make apps based off PRs or newly pushed branches that were separate from the staging and production apps.

CI / CD process:

CI process explanation: 
- Inside of the project directory there is a folder called .github/workflows with the file workflow.yml. 
- This file lets github know to run github action checks befor accepting a push or pull request (specified inside of the yml).
- The file will run any job mentioned inside of the yml as a github action check and follow the encapsulated steps.
- In our case, we use each job for testing. 
- On a push or pull request, the checks for each job wil run and if there is no errors, github will mark the push or pull request
  with a green check indicating that all checks passed and that that a merge is safe.

CD (The steps for CD are the same as deploying to heroku using a pipeline.):

CD process explanation: 
- Set up a new pipeline.
- Connect the github repository to the heroku pipeline in the settings.
- Enable review apps manually to be made inside your pipeline.
- Build a staging app off the staging branch in the github.
- (You may enable auto deploy inside the pipeline so any merge to staging rebuilds the staging app).
- After every pull request, a review app can be built based off that pull request.
- If the review app looks good merge the pull request to staging and then staging will automatically be rebuilt.
- Build production app by promiting the staging app to production if the staging app is good.

Additional details:

After building the app on heroku, go the the configuration settings of the app and add the api key in our MS TEAMS in order for the program to send emails upon checking in/out or rending an item.
***IF YOU DO NOT DO THIS THE APP WILL BREAK.***

