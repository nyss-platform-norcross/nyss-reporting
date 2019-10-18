# nyss_reporting

This app is for reporting symptoms in remote areas.

# Documentation for developers
## App
Most of the changes have to be made on the `/lib` folder. 
This is the folder containing the main app's flutter code.
The `main.dart` file is the main file, it is loaded when opening the app

## Server
The `/server` folder contains a really simple (for now) backend that contains some of the data. For the moment it is needed to get the app running.
To run it you need to download the dependencies with the command `yarn` or `npm i`, and do `yarn start` or `npm start`.

For the moment the endpoints are :
- `/phoneNumbers`
- `/healthRisks`
- `/caseReports`
- `/dataCollectors`

There is also a backend deployed at (https://reportingappbackendrc.herokuapp.com/)[https://reportingappbackendrc.herokuapp.com/].

# Actions
We have a simple action named "check" that check if the app build correctly.

# Setup
If you want to automatically format you commits you can run the following command 
```
git config core.hooksPath "./git_hooks"
```
This will add hooks to git that will handle the formating for you

# Releases 
