# EPLPlus App 

## Overview
This app is a minimal and streamlined English Premier League information app providing data fetched from the Football Data API (https://www.football-data.org). The app allows viewing of the league table, past and upcoming matches as well as favouriting teams by saving them to CoreData.
The aim of this project was to showcase retrieval of data from an API as well as complex JSON parsing. The app also utilises MapKit and modern UI features with built in animations, transitions and loading indicators. The app is in a usable and polished state and is viable for light use that does not exceed the API limit of 10 calls per minute.

## Important Information ‼️
- The free plan of the Football Data API is limited to **10 requests per minute**. If this is exceeded the loading indicator will continue to be displayed and the data will not load. Please wait 60 seconds before making another API request.
- The app has been designed and set to only support portrait mode.
- Development was completed on Xcode 15 which required minor implementation changes from Xcode 14 build. **Support for Xcode 14 is untested**


  
### How to run the app:
- Run and build the app through Xcode. It does not require any login just an active internet connection
- **Final version has been tested on Xcode 15 only**

## Features
- **Standings**: View a regulary updated premier league table that displays current points and other statistics 
- **Matches**: View past results and see date and time for upcoming games in the users time zone
- **Team Insights**: View information about teams including a MapKit view of the stadium location and statistics on the current season.
- **Light and Dark Mode Support**: The app will adapt to device light and dark mode.
- **Animations and Transitions**: The app features smooth animations and transitions for a great user experience.
- **Use of Combine Framework**: The app showcases the powere of SwiftUI's combine framework to use publishers and subscribers to communicate changes in app data
  

## Error Handling Strategy
The apps error handling strategy employs a variety of concepts to ensure a streamlined user experience. Error are thrown and caught and handled without the user noticing.
An example of this is if a team crest image cannot be loaded from local storage it will be redownloaded without any prompt to the user indicating an error has occured. 
The use of loading indicators and background API requests also ensures the user has a fluid experience and issues of data being decoded is handled gracefully using nil coalescing and default values.
