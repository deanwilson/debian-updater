# Debian Updater #

This code was written quite a long time ago when systems were much
simpler. While I've updated the manifest to make it work under modern
puppets I've left everything else alone to show how approaches have
changed over the years.

## Introduction ##

debian_updater is a simple Debian package upgrader written for use
within puppet. It has a list of packages to upgrade and ensures that
they eventually, within the puppet run window, all get upgraded.

Because of the installed-package filter you can have a super set of
packages that need upgrading and only those installed on a machine will
be upgraded. We use this (as one example) to list kernel package
upgrades - you can have both normal and bigmem listed and only the
correct one will be applied to each machine.

The module consists of three parts -
 * The configuration file that specifies which packages you'd like
   to update.
   - files/debian_updates
 * The script that checks if a package is installed.
   - files/package-installed
 * A subscribe that watches the config file and triggers the upgrades.

## Prerequisites ##

This module is self contained.

It may be worth using one of the Nagios checks that monitors packages in
need of an update.

## Notes ##

When this module is first added to client machines the client will do an
initial upgrade as the config file is new (and therefore changed).

You can track and apply sets of packages to install in many ways -

 * tag them
 * environments
 * force puppet runs on sets of machines
 * etc.

## Limitations ##

Because a subscribe is used to track the debian-updates file a package
will only be upgraded once if the file does not change. If another
release is made of the same package then you'll need to alter the
contents of 'debian-updates' to have it picked up again. This has only
been an issue twice in the last year for us, and 'luckily' someone found
a different package to patch the same day.

## License ##
BSD - [Dean Wilson](http://www.unixdaemon.net) - go forth and use the code.
