# GymondoAssessment
iOS Application to browse and explore exercises

## Requirements 
| Tool| Version |
|--|--|
| Xcode | 15.0 or later  |

## Architecture 
The project is builded with the MVVM Architectural design pattern.

[![GymondoAssessment](https://github.com/Sagar9821/GymondoAssessment/actions/workflows/ios.yml/badge.svg)](https://github.com/Sagar9821/GymondoAssessment/actions/workflows/ios.yml)
[![Gymondo](https://github.com/Sagar9821/GymondoAssessment/actions/workflows/SDK_ios.yml/badge.svg)](https://github.com/Sagar9821/GymondoAssessment/actions/workflows/SDK_ios.yml)

## Structure
```
.
├── Gymondo 
│   │    ├── Models 
│   │    ├── Service
│   │    │   ├── Exercise Services
│   │    ├── Networking
├── GymondoAssessment
│   │    ├── Resource
│   │    ├── Mocks
│   │    ├── UITesting # Testing helpers for UI Test cases
│   │    ├── Common
│   │    ├── Layouts
│   │    │   ├── Storyboard 
│   │    ├── Extentions
│   │    ├── Tools
│   │    ├── Scenes 
│   │    │   ├── Exercise 
│   │    │   │        ├── ExerciseList
│   │    │   │        │ ├── View
│   │    │   │        │ ├── ViewModel 
│   │    │   │        ├── ExerciseDetails
│   │    │   │        │ ├── View
│   │    │   │        │ ├── ViewModel
│   │    ├── Extensions
│   │    ├── Navigation
│   │    ├── AppDelegate
│   │    ├── SceneDelegate 
├── GymondoAssessmentTests
│   │    ├── Helpers
│   │    ├── Sceans
│   │    │   ├── Views
│   │    ├── ViewModel
├── GymondoAssessmentUITests # UI Test cases 
│   │    ├── ExerciseDetails
│   │    ├── Sceans
├── GymondoTests 
│   │    ├── Services
│   │    ├── Networking
│   │    ├── Test Helper
```

## Tests
The projects contain several test plans as follows:
| Test Plan| Run |
|--|--|
| `GymondoTests`| Calls the network api and validate the API response   |
| `GymondoAssessmentTests`| SDK tests, and End To End Tests   |
| `GymondoAssessmentUITests`| Run App Specific UI Tests  |
