## Setup ##

1. This app needs to be deployed on an Amazon instance. Get the instance .pem file & ssh into the instance.  

2. Clone this app using git clone. This is a Rails app, prepare the Rails app - bundle install etc.

3. Copy `run-worker.example` to `run-worker`. Populate the placeholder with Amazon credentials. 

4. Execute `run-worker`. This will start the agent.


### Architecture ###

Although this is a Rails app, there are nothing of Rails stuff that I have used here. Earlier I had thought of using the web app where the status of the agent worker can be shown, but then I realized that is not the requirement.

Instead of using any complex gems, I decide to follow [this guide](http://michalorman.com/2015/03/daemons-in-rails-environment/) which instructs on how easy is it to create a daemon that runs on the background. This seems to be the best I could do with the limited time I have.

The daemon is in `lib/tasks/daemon.rb`. `run-worker` just executes this daemon which has infinite loop in it. There is nothing else thats fancy here. The agent can't be given any other job to do either. 
