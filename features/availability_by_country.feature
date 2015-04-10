Feature: Availability by country

  Background:
    Given a release with different release dates for different countries

  Scenario Outline: The item should not be available before it has been released anywhere
    When I ask if it is available to purchase in <territory> before it has been released anywhere
    Then the answer should be false

    Examples:
      | territory |
      | AT        |
      | EE        |

  Scenario Outline: The availability of the item should depend on the country of purchase during the period between release dates
    When I ask if it is available to purchase in <territory> between the release dates
    Then the answer should be <available?>

    Examples:
      | territory | available? |
      | AT        | true       |
      | EE        | false      |

  Scenario Outline: The item should be available once it has been released everywhere
    When I ask if it is available to purchase in <territory> once it has been released everywhere
    Then the answer should be true

    Examples:
      | territory |
      | AT        |
      | EE        |