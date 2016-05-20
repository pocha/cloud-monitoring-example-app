## Cloud Monitoring app ##

There are two parts to the app - `monitoring_server` & `agent`. Please navigate to each directory to see the install instructions

### Setup ###

1. Setup `monitoring_server` on a server/machine of your choice. It is a Rails 4 app. Even on a non AWS machine, the server need to read data from AWS queue. So registration on AWS is mandatory

2. `agent` need to be manually setup at all machines that need monitoring. It is again a Rails 4 app which writes to AWS queue. 

### High Level Architecture ###

 *Amazon Queue for data ex-change* - Each agent writes to Amazon Queue from which the monitoring server reads the data. Monitoring server uses shoryken gem which creates multiple workers for a scalable architecture. *For security purpose, AWS key & secret are not left as part of the code. Rather a script a placeholder is created in both monitoring server & agent which is suppose to be filled & executed*.

### To-Do ###

Due to shortage of time, I got to spend only 4 hours on this assignment, including architecting as well as writing the code. 

1. *Remote agent installation from monitoring server* - Ideally, one should be able to remotely deploy agent to an already running instance. I am not sure how to do it through SDK. Ideally, the server should need the .pem file which should be passed to a bash script who in-turn will ssh to the server & automatically complete the steps mentioned under the `agent` installation. The next step would be to even create an instance (I am sure that can be done through SDK), download the pem file & complete the above steps.

2. *Remote server shutdown* - As for now, the remote server can't be shut as there is no provision. Right now the rails app does not have access to AWS credentials. That can be changed & using the same, a remote server can be shutdown. The SDK will require the instance id which can be either communicated by the agent or can be pre-stored in the monitoring server.

3. *Nosql & scalable monitoring web app* - This is a POC app. The rails app is webrick & the db is sqlite. I know both are bad choices but this is the best & fastest I could do in given time.
