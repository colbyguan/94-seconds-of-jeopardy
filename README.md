# 94 seconds of Jeopardy (94SoJ)
| <img src="/screens/iphone1.png" alt="screen1" height="400"/> | <img src="/screens/iphone2.png" alt="screen2" height="400"/> | <img src="/screens/iphone3.png" alt="screen3" height="400"/> |

## Authors
* Colby Guan

## Purpose
* 94SoJ is game that gives combines the app 94 seconds with the game Jeopardy - players have 94 seconds to answer as many question (or question as many answers) given the first letter of the answer.

## Features
* User is given a list of (category, price) pairs before each question and can choose which one to be their next question. This list is set in stone for the 94s duration and elements are eliminated by user skips/answers. Categories should be mostly unique with each other.
* Answer field indicates how many words and supports spacing and casing mistakes
* Skip-question ability that deducts 3 seconds
* Hint ability that fills in half of the letters and deducts 5 seconds

## Control Flow
* Landing screen has new game and help button
* Help button goes to help page which just explains to user how the game works and their abilities
* New game starts flow between 1) select (category, price) pair view to 2) the actual question + answer view and back

## Implementation
### Models
* JserviceModel - batch loading of Jeopardy Q/A data
  * Note: small bug - some jservice.io api responses don't play with the string replacement nicely, resulting in random '=' signs or just blank questions. Seems rare for the most part.
* QuestionsModel - dictionaries to Question objects
* GameModel - simple score and timer tracking

### Views
* Landing - Buttons
* Help - Back button, ImageView
* QuestionTable - ListView
* Question - TextField, Buttons

### Controller
* LaunchViewController
* HelpViewController
* QuestionsTableViewController
* QuestionViewController


