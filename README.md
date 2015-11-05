# 94 seconds of Jeopardy (94SoJ)
## Authors
* Colby Guan

## Purpose
* 94SoJ is game that gives combines the app 94 seconds with the game Jeopardy - players have 94 seconds to answer as many question (or question as many answers) given the first letter of the answer.

## Features
* User is given a list of (category, price) pairs before each question and can choose which one to be their next question. This list is set in stone for the 94s duration and items eliminated by user skips/answers. Categories should be mostly unique with each other.
* Answer field indicates how many words and supports simple spelling(?)/casing mistakes
* Skip-question ability that has a cooldown or deducts time left
* Hint ability that fills in random letters and has worse consequences as skip

## Control Flow
* Landing screen has new game and help button
* Help button goes to help page which just explains to user how the game works and their abilities
* New game leads to a 3-2-1 countdown and then flows between 1) select (category, price) pair view to 2) the actual question + answer view and back

## Implementation
### Model
* Questions.swift - planning to HTTP req to jservice.io API
* Game.swift - time, hints/skips management

### View
* LandingView - Buttons
* HelpView - Back button, ImageView
* CategoryListView - ListView
* QuestionView - TextField, Buttons

### Controller
* LandingViewController
* HelpViewController
* CategoryListViewController
* QuestionViewController
