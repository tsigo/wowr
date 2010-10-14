Feature: Search

  Scenario: Search for a character by name
    When I search for a character named "Tsigo"
    Then I should see the following as the first result:
      | battle_group | Stormstrike |
      | gender       | Male        |
      | guild        |             |
      | klass        | Priest      |
      | level        | 80          |
      | name         | Tsigo       |
      | race         | Undead      |
      | realm        | Mal'Ganis   |

  Scenario: Search for a guild by name
    When I search for a guild named "Juggernaut"
    Then I should see the following as the first result:
      | battle_group | Stormstrike |
      | realm        | Mal'Ganis   |
      | faction      | Horde       |

  Scenario: Search for an item by name
    When I search for an item named "Cake"
    Then I should see the following as the first result:
      | icon_base  | inv_boots_plate_09   |
      | id         | 45218                |
      | item_level | 200                  |
      | name       | Blood-Caked Stompers |
      | rarity     | 3                    |

  Scenario: Search for an arena team by name
    When I search for an arena team named "Lemon"
    Then I should see the following as the first result:
      | battle_group        | Retaliation |
      | faction             | Horde       |
      | games_played        | 0           |
      | games_won           | 0           |
      | last_season_ranking | 0           |
      | name                | LEMON       |
      | rating              | 1038        |
      | realm               | The Scryers |
      | season_games_played | 120         |
      | season_games_won    | 55          |
      | size                | 2           |
