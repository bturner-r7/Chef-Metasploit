Description
===========

Installs and configures a vulnerable web app target.

Using recipes in this cookbook will install **KNOWN VULNERABLE** apps and configuration.
Do not use this in a production environment.

Requirements
============

## Cookbooks:

* [apache (opscode)](https://github.com/opscode-cookbooks/apache2)
* [java (opscode)](https://github.com/opscode-cookbooks/java)
* [mysql (opscode)](https://github.com/opscode-cookbooks/mysql)
* [postgres (rapid7)](https://github.com/rapid7/Chef-Metasploit/tree/master/cookbooks/postgresql)
* [tomcat (opscode)](https://github.com/opscode-cookbooks/tomcat)

## Platforms:

* Ubuntu

Usage
=====

This will install and _incorrectly_ configure multiple applications to give you
a vulnerable web app target for testing.

The default recipe will install all components:

    { "run_list": ["recipe[web-target]"] }


Recipes
=======

apache2
-------

* Installed on port 80
* All the target pages live under /var/www

mysql
-----

* User: root
* Password: msfadmin

postgresql
----------

* User: msfadmin
* Password: msfadmin

tomcat
------

* Installed on 8080
* No apps installed on it
* Manager is present, for exploit via tomcat_mgr_deploy exploit
* Username: tomcat
* Password: tomcat

dvwa
----

* Dvwa is a svn repo of Damn Vulnerable Web App. The webapp is setup with
  * Username: admin
  * Password: password
  * Default security level: low (this can be configured within the app to
    make vulns more difficult to exploit)

shellol
-------

* ShelLOL is a git repo and can be updated via git. It is a testbed for OS
  Command Injection vulns

sqlol
-----

* SQLoL is a git repo, and is a php testbed for SQLi vulns

tikiwiki
--------

* Tikiwiki-1.9.4 contains a vulnerable version of tikiwiki that is populated
  with about 500 pages in hierarchical link trees. Some of these contain
  sensitive customer data.
* Tikiwiki is setup with:
  * Username: admin
  * Password: msfadmin
* Helper scripts in `/usr/local/bin` for generating random data:
  * tikiwiki-create-lorem-pages – This will create 400 pages in the wiki, all with
    randomized text for the description and content. They are setup in a 4
    level deep link tree from the homepage for testing the crawler.
  * tikiwiki-create-persona-pages – This takes an argument for the number of pages to
    create. Each page it creates has randomly generated personal information
    such as name, phone number, credit card data, ssn, etc. Once it has created
    all those pages it creates a ‘customers’ page with lniks to each one. The
    customers page is then linked from the homepage so it can be crawled.
  * tikiwiki-reset-pages – This removes all pages from tikiwiki except the homepage,
    and blanks the content of the homepage.

webdav
------

* http\_put\_php is un unauthenticated webdav folder allowing the HTTP PUT verb

websploit-tests
---------------

* Websploit-Tests is a git repo run by tasos and control various test specific
  for Metasploit Pro Web Exploit coverage

xmlmao
------

* XMLmao is a git repo and is a php testbed for XML/XPATH injection vulns

xssmh
-----

* XSSmh is a git repo and is a php testbed for Cross-Site Scripting vulns
