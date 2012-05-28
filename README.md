# Metasploit Chef Cookbooks

Contains cookbooks for creating build and test systems.  

Using [starter repo from OpsCode](https://github.com/opscode/chef-repo).


## Why Chef?
Chef provides us the ability to describe our infrastructure configuration in code with very little effort.  Not only have we therefore created documentation of what is required to build our various disparate systems, we've also created runnable code that will create those systems given a basic initial configuration.

Contrary to what you may have heard, Chef can be useful with even a single server to manage.  The ability to do [Chef Solo runs](http://wiki.opscode.com/display/chef/Chef+Solo) means that setting up a new server from local (to that server) commands is as easy as pulling down the cookbooks and running a single command.  There's no need for a Chef Server to provide command-and-control for the VMs you are configuring.  And conversely, nothing about Chef Solo keeps you from enhancing your Chef setup to include a server in the future.

Chef shouldn't be considered an alternative to bash scripts, or an alternative to using VM snapshots taken by your hypervisor.  It's far more capable than configuration management approaches using either of those two things exclusively.  

In fact, our approach to virtual hardware management assumes the usage of all three.


## How to use this repo (Chef Solo)

### Option #1 - from scratch
Use this option if you've got nothing more than a bare install of Ubuntu server.  In this case, you can get Chef-ready with this one-liner (requires sudo):

<pre>
wget https://raw.github.com/rapid7/Chef-Metasploit/master/bootstrap.sh && bash bootstrap.sh
</pre>

### Option #2 - from a prepped snapshot
You can use this option if you're maintaining a snapshot of the VM post-bootstrap, which you should be.

First, get the cookbooks (this repo):

<pre>
sudo git clone https://github.com/rapid7/Chef-Metasploit.git /var/chef
</pre>

Then fire off a solo run of your desired node type.  This example turns the node into an instance of the "dev-builder" role:
<pre>
sudo chef-solo -j /var/chef/solo-nodes/dev-builder.json
</pre>

That will start a Chef run and install the things necessary to turn the VM into a development environment suitable for usage with the Jenkins CI/build system.