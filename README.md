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

The ganesha module is intended to install and set up NFS Ganesha service. Although hosted on the OpenStack infrastructure, it does not require to sign a CLA nor is it restricted to OpenStack users. It benefits from a structured development process that helps federate the development effort. Each feature is tested with integration tests involving virtual machines to show that it performs as expected when used with a realistic scenario.

Module Description
------------------

The ganesha module is a thorough attempt to make Puppet capable of managing the entirety of ganesha.

Setup
-----

**What the ganesha module affects**

* [Ganesha](https://launchpad.net/puppet-ganesha/), the NFS Ganesha service.

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
