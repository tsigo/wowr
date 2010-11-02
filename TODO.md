TODO
====

## Restructure of 'lib/wowr' Directory

restructure gem library, reducing number of lines per *.rb file, directory module name and *.rb file class name, making files smaller and easier to comprehend,
this structure then would be duplicated through spec/, as refactoring occurs orig files will be left along the class will simply subclass the new module/class
goal would be to help identify potential areas (duplicated patterns) that could use additional refactoring

current filenames and line counts:

    $ wc -l lib/**/*.rb | sort -n
           3 lib/wowr/version.rb
          38 lib/wowr/general.rb
          67 lib/wowr/extensions.rb
          78 lib/wowr/calendar.rb
          79 lib/wowr/arena_team.rb
          85 lib/wowr/dungeon.rb
          85 lib/wowr/guild.rb
         143 lib/wowr/achievements.rb
         163 lib/wowr/exceptions.rb
         191 lib/wowr/guild_bank.rb
         628 lib/wowr/item.rb
         847 lib/wowr/character.rb
        2407 total

purposed new structure something like:

    lib/wowr/armory/character/base.rb
    lib/wowr/armory/characeter/info.rb
    lib/wowr/armory/characeter/full.rb
    lib/wowr/armory/character/detail/melee.rb
    lib/wowr/armory/character/detail/ranged.rb
    lib/wowr/armory/character/detail/weapon_skill.rb

## Performance Profiling - Perftools

identify slow areas within codebase

* http://github.com/tmm1/perftools.rb

## Use Nokogiri gem

  replace Hpricot with Nokogiri gem, but wait until more specs and code coverage are in place

## Ruby 1.9

Ensure Wowr works with Ruby 1.9.2 at a minimum

## startsQuest elements

Handle `startsQuest` elements on item-info pages. Example:

* http://www.wowarmory.com/item-info.xml?i=51316
