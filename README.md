## Password Service

### Description
Determine password strength based on certain characteristics such as presence of numbers, uppercase letters, symbols etc.

### Prerequisites
- ruby (2.6.3)
- bundler (1.17.3)
- node (10.18.0)
- npm (6.13.4)

### How to run the project

`$ git clone git@github.com:jakubkouba/pasword-service.git`

`$ cd password_service`

`$ ./start_password_service`

Then got to browser and enter this url: `http://localhost:4567` nad tart type to the field

To run the tests: `$ rspec`


### Notes
The service can be configured by adding and removing certain rules and setting a thresholds for good and strong password.
Each rule have a score and option which can be used to alter behaviour. Every new rule needs to take a password as an argument.
Score an option are set for defaults abd can be override
Every rule needs to implement `passsed?` method which returns true if passed the criteria or false if failed. 

There are couple things that could be further improved:
- Password strength calibration: It passes all criterias for to be a strong password, however, for some cases when the password should be weak
is strong. This is due to bad calibration of score and thresholds.
- Case words criteria: I think I implemented it incorrectly by checking for number of occurrences upper case characters 
instead of sequence of uppercase characters
- There are certain repetition of code in the rules. those which can take an integer (most of them) as an argument. This could be extracted into a module probably
 to share the behaviour across the rules.
- The option argument for rules could be renamed to better express the intention.
- Debounce delay when typing the password into the field on FE: Currently the endpoint is hit each time a user starts to type.
This could be optimize by waiting certain period of time to collect characters and then send the request.
