@mod @mod_bigbluebuttonbn @guest_access_link @adminsetting
Feature: Within a moodle instance, an administrator should be able to set the value for "Allow guest access links" in BigBlueButtonBN for the entire Moodle installation.
  In order to define the adminsettings of a BigBlueButtonBN instance,
  As an admin
  I need to default values for BigBlueButtonBN settings.

  Background:
    Given the following "users" exist:
      | username | firstname | lastname | email |
      | teacher1 | Teacher | 1 | teacher1@example.com |
    And the following "courses" exist:
      | fullname | shortname | category | groupmode |
      | Course 1 | C1 | 0 | 1|
    And the following "course enrolments" exist:
      | user | course | role |
      | teacher1 | C1 | editingteacher |

  @javascript
  Scenario: Switch as an admin to the adminsettings of the module bigbluebuttonbn and change the value of "Allow guest access links" to "Yes". Then login as a teacher and add a new bigbluebuttonbn to a course and check whether the settings for an access guest link is visible.
   Given I log in as "admin"
    And I navigate to "Plugins > Activity modules > BigBlueButtonBN" in site administration
    Then the field "Allow guest access links" matches value "0"
    And I set the field "Allow guest access links" to "1"
    And I press "Save changes"
    And I log out
    And I log in as "teacher1"
    And I am on "Course 1" course homepage
    And I turn editing mode on
    And I add a "BigBlueButtonBN" to section "1" and I fill the form with:
      | Virtual classroom name | Test BigBlueButtonBN - Adminsetting: Allow access guest link |
      | Description | Add a BigBlueButtonBN to the current course with access guest link |
    And I follow "Test BigBlueButtonBN - Adminsetting: Allow access guest link"
    And I navigate to "Edit settings" in current page administration
    And I expand all fieldsets
    Then I should see "External guest access link"
    And I should see "Create guest access link for external participants."
    And the field "Create guest access link for external participants." matches value "0"

    Then I log out

  @javascript
  Scenario: Switch as an admin to the adminsettings of the module bigbluebuttonbn and change the value of "Allow guest access links" to "No". Then login as a teacher and add a new bigbluebuttonbn to a course and check whether the settings for an access guest link is not visible.
    Given I log in as "admin"
    And I navigate to "Plugins > Activity modules > BigBlueButtonBN" in site administration
    And I set the field "Allow guest access links" to "0"
    And I press "Save changes"
    And I log out
    And I log in as "teacher1"
    And I am on "Course 1" course homepage
    And I turn editing mode on
    And I add a "BigBlueButtonBN" to section "1" and I fill the form with:
      | Virtual classroom name | Test BigBlueButtonBN - Adminsetting: not allow access guest link |
      | Description | Add a BigBlueButtonBN to the current course without activated access guest link |
    And I follow "Test BigBlueButtonBN - Adminsetting: not allow access guest link"
    And I navigate to "Edit settings" in current page administration
    And I expand all fieldsets
    Then I should not see "External guest access link"
    And I should not see "Create guest access link for external participants."