  

# Share Desk App

### live site: https://sharedesk1.onrender.com/

<img src="app/assets/images/share_desk.gif" alt="application_screenshot" width="500" />

---
## Technology

- Ruby on Rails 6.0

- Javascript

- JQuery

- PostgreSQL

- AWS S3 

- Bootstrap

- Turbolink/Stimulus.js

- Omniauth(Facebook/Google)

- Google Map API / Geocode

- Devise/ Raty/ Ransack/ Active_Storage/ Pagy/ JQuery UI/ Datepicker/ Toastr

- SASS

- Webpack

- HTML5

---
## Motivation

This application aims at a web product which serve local community by hosting your private home/office for public work space and share with community around the world in any city. It started with the fact that we have a lack of public space for work and study in local community because of COVID pandemic 2020.

Inspired by WeWork and Air B&B.

User can sign up their home/office space for rental business. Customers can search their local area for available shared work spots near by.

---

## Features

### User Account/ Profile Update with an Avatar

Anyone can do regular search for the available spaces, however, for advanced features such as making a reservation or hosting spaces, users should sign up and create account. Account could be created using Omniauth from Facebook/Google Account with just a click as well as regular sign up using your email address. Devise gem was used for more sophisticated authorization, and login/signup process.

Profile page illustrates user information with a user photo or avatar and shows all the hosting space list. User can update all of their information anytime easily.

### Upload Photos to AWS S3

Currently the app was deployed to Heroku.com, and for the limitation of long term storing photo datas, cloud file uploading AWS/S3 was used with Acitive_Storage Rails gem for easy image saving and loading. Image_Processing gem was used for manipulation of photos as well.

### Hosting your home / apartment for workspace rental

User can host their own home/apartment/office for desk renting business. Space was categorized in single private desk, shared large table, or private room. User can price reasonably on their own for local supply and demand. Creating page was provided with detailed categorized form with various inputs including uploading many images for the space. After the listing, managing page was provided with total sales and reserved detail page as well.

### Locating the address on Google Map

Google Map API was used to locate your hosting address on the map interactively. Individual space page also shows the description of the space along with the google map pointer.

### Advance Searching in Detail

As well as the navbar serching ability on any page, advanced detailed search feature was introduced. User can select differenct specific needs accordingly. Rails gem Ransack was chosen to implement sophistecated multiple keyward searching through the backend database.

### Rating Reviews with Star System

Visually recognied star rating sytem was used for customers who reserved and experienced its service to write feedback and rate the satisfaction level with easily implementing gem Raty. Average rating of the spaces could be seen beside the title of the space at first.

### Make Reservation with Datepicker

JavaScript and Ajax call was used for selecting a reservation day and creating it. User can reverve starting day and finishing for more than one day ahead of time.
JQuery Datepicker plugin was also used. A little complicated business logic was needed to implement to set up the available date based on the availablilty and starting/ending dates. JavaScript was essential to call backend 'reservation' model to work on the background smoothly and promptly.

### Local Searching based on Customer Browser Location

Geocode gem was used to detect the local location of the user browser so the local area availability searching was provided just with a button click on home page.

### Convinient Login using Omniauth(Google/Facebook)

Devise gem was used together with omniauth authentification from preset Google/Facebook services when authentification call was reached from Sharedesk url address.

### Notification with Toastr

Toastre gem was used for more informative notification services including different color notices, exposure/dissapearing time.

### Infinite Scrolling for Search Result using Ajax javascript call

Stimulus.js was used to listen html events on the web service. Particularly it was used for infinite scrolling when next page of search results need to be Ajax called and the data needed to be loaded easily as soon as the scrolling down event was reached at certail point on the bottom. Stimulus also listen to the event for finishing up the infinite scrolling when it reached the last item on the result.

### Pagination for each page with pagy gem

Simple pagination gem Pagy was used to implement organization of the different lists with different amount of list/page to show on each page.

---
## Future Features to Come

- Emailing notification
- API location using Jbuilder for React/Redux
- Hourly reservation
- Conversation(chatting) between customers and hosts
- Payment system 
---
## License ##
MIT © Justin K Lee
