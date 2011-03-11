Wowr
====
Ruby Library for the World of Warcraft Armory

NOTICE: The current development version accesses the old wowarmory.com XML API, and as such will be outdated. We are willing and anxious to update the library to work with the new battle.net Armory site, just as soon as they provide a non-HTML API for us to use.
====

Introduction
------------

Wowr is an API for accessing data in the World of Warcraft Armory. Using the
XML data provided by the armory, it allows developers to query World of
Warcraft items, characters, guilds and arena teams. It is designed to support
developers that wish to add WoW information to their Ruby-powered site, as well
as larger guild or portal sites for many users.

## Usage

See the files in the examples directory.

## Documentation

Please view the [RubyDoc](http://wowr.rubyforge.org/doc/) for more information on usage.

## Installation

Wowr can be installed through RubyGems using the command below:

    gem install wowr

Alternatively, the latest version can be downloaded from Git with:

    git clone git://github.com/pwood/wowr.git

## Development

Prior to running specs, developers should ensure Warcraft Armory file fixtures
are up-to-date.

    # Download only missing file fixtures
    rake file_fixtures:initialize

    # Update all file fixtures
    rake file_fixtures:update

    rake spec

## Authors

Originally written by Ben Humphreys benhumphreys[at]gmail.com

Maintained by Peter Wood peter+wowr[at]alastria.net

People who submitted patches:

* Renaud Chaput
* Michael Chen
* Ken Preudhomme
* Scott (thestorcks.de)

Apologies to anyone missed, please let Peter Wood know if this is the case.
