# EPLPlus App 

## Overview
This app is a minimal and streamlined English Premier League information app providing data fetched from the Football Data API (https://www.football-data.org). The app allows viewing of the league table, past and upcoming matches as well as favouriting teams by saving them to CoreData.
The aim of this project was to showcase retrieval of data from an API as well as complex JSON parsing. The app is in a usable and polished state complete with loading indicators and animation.

## Important Information ‼️
The free plan of the Football Data API is limited to **10 requests per minute**. If this is exceeded the loading indicator will continue to be displayed and the data will not load. Please wait 60 seconds before making another API request.


  
### How to run the app:
Run and build the app through Xcode. It does not require any login just an active internet connection

## Features
- **Standings**: View a regulary updated premier league table that displays current points and other statistics 
- **Matches**: View past results and see date and time for upcoming games in the users time zone
- **Team Insights**: View information about teams including a MapKit view of the stadium location and statistics on the current season.
- **Light and Dark Mode Support**: The app will adapt to device light and dark mode.
- **Animations and Transitions**: The app features smooth animations and transitions for a great user experience.
  

## Error Handling Strategy
The apps error handling strategy employs a variety of concepts to ensure a streamlined user experience. Error are thrown and caught and handled without the user noticing.
An example of this is if a team crest image cannot be loaded from local storage it will be redownloaded without any prompt to the user indicating an error has occured. 
The use of loading indicators and background API requests also ensures the user has a fluid experience and issues of data being decoded is handled gracefully using nil coalescing and default values.
