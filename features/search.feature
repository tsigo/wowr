Feature: Character search

  Scenario: Search for a character by name
    When I search for a character named "Tsigo"
    Then I should see the following result:
      | battle_group | Stormstrike |
      | gender       | Male        |
      | guild        |             |
      | klass        | Priest      |
      | level        | 80          |
      | name         | Tsigo       |
      | race         | Undead      |
      | realm        | Mal'Ganis   |
