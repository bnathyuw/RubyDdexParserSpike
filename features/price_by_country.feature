Feature: Price by country

  Background:
    Given a release with different prices for different countries

  Scenario Outline: The item should have no price when it has not been released anywhere
  	When I ask for the purchase price in <territory> before it has been released anywhere
    Then I should not get a price

 	Examples:
 	  | territory |
 	  | AT        |
 	  | EE        |

  Scenario Outline: The item should have the appropriate price for the territory
  	When I ask for the purchase price in <territory> once it has been released everywhere
  	Then the price should be <price>

  	Examples:
  	  | territory | price |
  	  | AT        | STAP  |
  	  | EE        | TAP   |