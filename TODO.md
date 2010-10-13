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

    lib/wowr/classes/character/base.rb
    lib/wowr/classes/characeter/info.rb
    lib/wowr/classes/characeter/full.rb
    lib/wowr/classes/character/detail/melee.rb
    lib/wowr/classes/character/detail/ranged.rb
    lib/wowr/classes/character/detail/weapon_skill.rb

## Mock Web Requests to WoWArmory.com in Specs

look into either Fakeweb or Webmock gems

* http://github.com/chrisk/fakeweb
* http://github.com/bblimke/webmock

## Performance Profiling - Perftools

identify slow areas within codebase

* http://github.com/tmm1/perftools.rb

## Overall Codebase Cleanup

new rake tasks to perform code formatting tasks

* convert hard-tabs to soft-tabs
* remove trailing whitespace
* remove gratuitous blank lines

Unix Commands:

    cat filename | sed 's/\t/  /g' > .soft_tabs; cp .soft_tabs filename; rm .soft_tabs; echo filename;
    cat filename | sed 's/[ \t]*$//' > .whitespace; cp .whitespace filename; rm .whitespace; echo filename;
    cat filename | sed '/./,/^$/!d' > .blank_lines; cp .blank_lines filename; rm .blank_lines; echo filename;
