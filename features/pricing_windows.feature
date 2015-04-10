Feature: Pricing windows

  Background:
    Given a release whose price varies over time

  Scenario Outline: The item should not be available before it has been released
    When I want to purchase it in JP <when>
    Then it should be not available
    And it should not have a price

    Examples:
      | when                                     |
      | long before the first deal starts        |
      | on the day before the first deal starts  |

  Scenario Outline: The item should show the first price during the first deal
    When I want to purchase it in JP <when>
    Then it should be available
    And its price should be STAP

    Examples:
      | when                              |
      | on the day the first deal starts  |
      | on the last day of the first deal |

  Scenario Outline: The item should show the second price during the second deal
    When I want to purchase it in JP <when>
    Then it should be available
    And its price should be TP

    Examples:
      | when                              |
      | on the day the second deal starts |
      | long after the second deal starts |