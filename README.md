# CloudHop

## Table of Contents
1. [Overview](#Overview)
1. [Product Spec](#Product-Spec)
1. [Wireframes](#Wireframes)
2. [Schema](#Schema)
3. [Sprint Updates](#Updates)
4. [Local Demo Day Video](#Demo)

## Overview
### Description
Travel recommendation app for allowing users to sign up for accounts and choose places they like. Recommendation system then will take that data and use machine learning to recommend them similar locations around the world they may like. Users may follow each other and like and share locations for their followers to view.

### App Evaluation
[Evaluation of your app across the following attributes]
- **Category:** Social networking / recommendation app
- **Mobile:** This app is targeted for mobile IOS devices, however it can easily be implemented as a web based application to allow accessibility to more users.
- **Story:** Allows users to get recommendations for places they would like to travel to based on the information they provide. The quality of these recommendations improve as more data is available. Users can also follow each other and share locations similar to other social media applications, but themed on travels.
- **Market:** Anyone can use this application, either just for the recommendaations, just as a social platform, or both.
- **Habit:** This app cxan be used as often as a user requires, it should be mobile and accessible to be used in many locations, since the purpose is for travel.
- **Scope:** Starting out, the main feature to build is the recommendation aspect. Having this can set it apart from just being another social media application and actually provide users with a reason to use the application. Being that the app is themed on travel, the social aspect is the next step, as users will naturally want to share their explorations. Having a way to add more data to the users likes will also benefit the recommender as it can then provide more accurate recommendations.

## Product Spec

### 1. User Stories (Required and Optional)

**Required Must-have Stories**

* [Database for user accounts and likes.] (DONE)
* [User registration] (DONE)
* [User login and logout] (DONE)
* [recommendation system to use world cities dataset to predict locations users may like.] (DONE)
* [UI for viewing the recommendations] (DONE)
* [UI for user account creation and selecting basic information on preferences.] (DONE)
* [UI for all locations view] (DONE)
* [UI for feed and viewing followers.] (DONE)

**Optional Nice-to-have Stories**

* [UI for viewing different user profile accounts] (DONE)
* [searching for different user accounts] (DONE)
* [view for explore, to see locations and activities within a city]
* [settings page] (DONE)

### 2. Screen Archetypes

* [Account creation or Sign in]
   * [User registration]
   * [User login and logout]
* [Selection for default likes (for new accounts)]
   * [UI for user account creation and selecting basic information on preferences.]
* [Homescreen]
   * [recommendation system to use world cities dataset to predict locations users may like.]
   * [UI for viewing the recommendations.]
   * [UI for feed and viewing follower likes.]
* [User profile page]
   * [UI for viewing different user profile accounts]
   * [searching for different user accounts]
* [Explore view]
   * [view for explore, to see locations and activities within a city]

### 3. Navigation

**Tab Navigation** (Tab to Screen)

* [Homescreen]
* [Explore]
* [Profile]

**Flow Navigation** (Screen to Screen)

* [Account creation]
   * [Leads to registration]
   * [Then to selecting preferences]
   * [Finally to Homescreen]
* [Login]
   * [Leads to Homescreen]
* [Search]
   * [Leads to text input, then a feed for user profile searches.]
* [Profile]
   * [Will have a flow to settings]


## Wireframes

### [BONUS] Digital Wireframes & Mockups
![image](https://user-images.githubusercontent.com/75550025/158932769-98008893-96bc-4497-8682-a411a65be5de.png)

### [BONUS] Interactive Prototype

https://user-images.githubusercontent.com/75550025/158933338-1043a890-a0cb-425b-9566-81a272da1b7b.mp4


## Schema 
[This section will be completed in Unit 9]
### Models

- [User Model]

| Property | Type | Description |
|----------|------|-------------|
| Email | String | String for unique email used as doc id |
| Name | String | String for holding the Username for each user |
| Country | String | Holds the users home Country |
| Preferences | Pointer Array | Pointer array to list of the user liked locations |
| ProfileImage | File | Holds the users profile image |
| CreatedAt | DateTime | Date of user account creation |
| SharedPosts | Pointer Array | Array of user liked/shared posts |

- [Location Model]

| Property | Type | Description |
|----------|------|-------------|
| LocationId | String | Unique id for each location |
| Name | String | String for holding the location name |
| LocationImage | File | Image of the location |
| Description | String | Holds a quick overview description of the location |
| Rating | Number | aggregate star rating for the location from google places API |
| PriceLevel | Number | number from 1-4 for the relative cost of travel to that location |

- [Posts Model (Stretch Feature)]

| Property | Type | Description |
|----------|------|-------------|
| PostId | String | String for holding the Username for each user |
| Author | Pointer | Pointer to user that authored the post |
| ProfilePicture | Pointer | Pointer to user collection profile picture |
| LocationImage | Pointer | Pointer to the location |
| LikesCount | Number | Number of likes for the post |


### Networking
- [HomeScreen]
    - (Read/GET) Query all recommended locations from firebase firestore
    - (Read/GET) Query locations from Google places API for location data from around the world 
    - (Create/POST) Create a new like on a location
    - (Delete/DELETE) Remove a like from a location
- [Detailed Location View]
    - (Read/GET) Query location data where location id is equal to the currrent location selected
    - (Create/POST) Create a new like on a location
    - (Delete/DELETE) Remove a like from a location
- [Preference View]
    - (Read/GET) Query a small amount of locations from firebase firestore
    - (Create/POST) Update a user preference to add that location to the likes 
    - (Delete/DELETE) Remove a user preference
- [Recommendation View]
    - (Read/GET) Query locations from firebase firestore that match the user preferences based on the ML recommendation system model.
    - (Create/POST) Update a user preference to add that location to the likes 
    - (Delete/DELETE) Remove a user preference

## Updates

https://user-images.githubusercontent.com/75550025/161202757-d49b6a5e-ab23-49fa-9aa4-632a63e6dcf8.mp4


https://user-images.githubusercontent.com/75550025/162360108-76d1ff23-7bd4-4f27-89ad-060e6cd99b9b.mp4

## Demo

https://youtu.be/Iiic36AW6jg
