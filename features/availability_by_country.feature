Feature: Availability by country

  Background:
    Given a release with different international release dates

  Scenario Outline: The item should not be available before it has been released anywhere
    When I ask if it is available in <territory> before any release date
    Then the answer should be false

    Examples:
      | territory |
      | AT        |
      | EE        |

  Scenario Outline: The availability of the item should depend on the country of purchase during the period between release dates
    When I ask if it is available in <territory> between the release dates
    Then the answer should be <available?>

    Examples:
      | territory | available? |
      | AT        | true       |
      | EE        | false      |

  Scenario Outline: The item should be available once it has been released everywhere
    When I ask if it is available in <territory> after any release date
    Then the answer should be true

    Examples:
      | territory |
      | AT        |
      | EE        |
