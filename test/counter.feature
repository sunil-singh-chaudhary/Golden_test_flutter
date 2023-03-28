Feature: Counter
  Scenario: Initial counter value is 0
    Given The app is running
    Then I see {'0'} text

  Scenario: Plus now press on tap  
    Given The app is running
    When I tap {Icons.add} icon 
    Then I see {'1'} text