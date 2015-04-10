Feature: Availability by country

  Background:
    Given a release with different release dates for different countries

  Scenario Outline: The item should not be available before it has been released anywhere
    When I want to purchase it in <territory> before it has been released anywhere
    Then it should be not available

    Examples:
      | territory |
      | AT        |
      | EE        |

  Scenario Outline: The availability of the item should depend on the country of purchase during the period between release dates
    When I want to purchase it in <territory> between the release dates
    Then it should be <available?>

    Examples:
      | territory | available?    |
      | AT        | available     |
      | EE        | not available |

  Scenario Outline: The item should be available once it has been released everywhere
    When I want to purchase it in <territory> once it has been released everywhere
    Then it should be available

    Examples:
      | territory |
      | AT        |
      | EE        |