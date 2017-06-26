ganesha
=======

#### Table of Contents

1. [Overview - What is the ganesha module?](#overview)
2. [Module Description - What does the module do?](#module-description)
3. [Setup - The basics of getting started with ganesha](#setup)
4. [Implementation - An under-the-hood peek at what the module is doing](#implementation)
5. [Limitations - OS compatibility, etc.](#limitations)
6. [Development - Guide for contributing to the module](#development)
7. [Contributors - Those with commits](#contributors)

Overview
--------

The ganesha module is a part of [OpenStack](https://www.openstack.org), an effort by the OpenStack infrastructure team to provide continuous integration testing and code review for OpenStack and OpenStack community projects not part of the core software.  The module its self is used to flexibly configure and manage the FIXME service for OpenStack.

Module Description
------------------

The ganesha module is a thorough attempt to make Puppet capable of managing the entirety of ganesha.  This includes manifests to provision region specific endpoint and database connections.  Types are shipped as part of the ganesha module to assist in manipulation of configuration files.

Setup
-----

**What the ganesha module affects**

* [Ganesha](https://wiki.openstack.org/wiki/Ganesha), the FIXME service for OpenStack.

### Installing ganesha

    ganesha is not currently in Puppet Forge, but is anticipated to be added soon.  Once that happens, you'll be able to install ganesha with:
    puppet module install openstack/ganesha

### Beginning with ganesha

To utilize the ganesha module's functionality you will need to declare multiple resources.

Implementation
--------------

### ganesha

ganesha is a combination of Puppet manifest and ruby code to delivery configuration and extra functionality through types and providers.

Limitations
------------

* All the ganesha types use the CLI tools and so need to be ran on the ganesha node.

Beaker-Rspec
------------

This module has beaker-rspec tests

To run the tests on the default vagrant node:

```shell
bundle install
bundle exec rake acceptance
```

For more information on writing and running beaker-rspec tests visit the documentation:

* https://github.com/puppetlabs/beaker-rspec/blob/master/README.md

Development
-----------

Developer documentation for the entire puppet-openstack project.

* http://docs.openstack.org/developer/puppet-openstack-guide/

Contributors
------------

* https://github.com/openstack/puppet-ganesha/graphs/contributors
