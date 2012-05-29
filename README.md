# Metasploit Chef Cookbooks

Contains cookbooks for creating build and test systems.  

Using [starter repo from OpsCode](https://github.com/opscode/chef-repo).


## Why Chef?
Chef provides us the ability to describe our infrastructure configuration in code with very little effort.  In one step we create documentation of what is required to build our various disparate systems, as well as code that will actually perform the build/configuration operations in a predictable, idempotent way.  

Three big things to know about Chef:

* **Chef manages state** -- you'll get the most out of Chef if you don't just think of it as a way to create new nodes, but more broadly as a way to put your infrastructure into a known state.  So you can use it to reset services for different purposes, change the role a VM is being used for, etc.
* **Chef can work small** -- contrary to what you may have heard, Chef doesn't require huge infrastructure needs to be useful -- you can get a lot out of it with even a single server to manage by using [Chef Solo runs](http://wiki.opscode.com/display/chef/Chef+Solo).  Chef Solo is a mode that lets you use Chef to setup a server *from that server*.  This makes configuring a server as easy as updating a local copy of the cookbooks and calling a single CLI command with the **chef-solo** binary.
* **Chef can get big** -- nothing about using Chef Solo to manage things node-by-node locks you into that mode of working should you decide to use Chef Server later.  The cookbooks will be exactly the same.

Chef shouldn't be considered an alternative to bash scripts, or an alternative to using VM snapshots taken by your hypervisor.  It's far more capable than configuration management approaches using either of those two things exclusively.  

But we don't descriminate -- our approach to virtual hardware management leverages all three.


## How to use this repo (Chef Solo)

### Option #1 - from scratch
Use this option if you've got nothing more than a bare install of Ubuntu server.  In this case, you can get Chef-ready with this one-liner (requires sudo):

<pre>
wget https://raw.github.com/rapid7/Chef-Metasploit/master/bootstrap.sh && bash bootstrap.sh
</pre>

Now do the stuff in Option 2 below.

### Option #2 - from a prepped snapshot
You can use this option if you're maintaining a snapshot of the VM post-bootstrap, which you should be.

First, get the cookbooks (this repo):

<pre>
sudo git clone https://github.com/rapid7/Chef-Metasploit.git /var/chef
</pre>

Consider adding a snapshot at this point to allow you to roll back and
configure the node differently.

Then fire off a solo run of your desired node type.  This example turns the node into an instance of the "dev-builder" role:
<pre>
sudo chef-solo -j /var/chef/solo-nodes/dev-builder.json
</pre>

That will start a Chef run and install the things necessary to turn the VM into a development environment suitable for usage with the Jenkins CI/build system.
