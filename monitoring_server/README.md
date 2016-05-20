## Monitoring Server ##

This a Rails 4 app that largely stores monitoring data sent to it by agents. 

### Running the app ###

1. Setup this app as regular Rails app. git clone, bundle install, rake db:migrate etc.

2. Run rails app. Navigate to localhost:3000 to view list of agents (will be empty to start with).

3. Navigate to agent app. Follow the instructions to set it up. It will start pushing data to the Amazon queue.

4. Copy `shoryken-worker.example` to `shoryuken-worker`. Populate Amazon key & secret. It is needed to read the data from the queue. Run the command mentioned in the file or just run the file as ./shoryken-worker (unix systems). Logs are genereated in log/shoryuken.log 

5. Refresh localhost:3000 to view the agents & the data.

![Main app screenshot](images/app.png)

### Architecture ###

1. *Agent Data Storage Layer* - There is a background worker that keeps reading data from Amazon Queue. All agents are suppose to push data into the queue. File  
