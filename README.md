# Road Trip

## What is this?

Have you ever been on a road trip and tried using Yelp to find your next pit stop? I have and I found that all too often the restaurant that we could all agree on was 20 miles in the wrong direction. I decided I had had enough and needed to take matters into my own hands. This app helps you filter your Yelp results to only the ones that are in front of you. Happy road tripping!

Unfortunately, Yelp limits your API calls, so I opted not to publish this on the App Store. 

## Getting Started

Once you have a Yelp account, register for an API key by clicking [here](http://www.yelp.com/developers/getting_started/api_access). 

Add those values into the `YelpAPICredentials.h` file. I used `git update-index --asume-unchanged` on the `YelpAPICredentials.h` file, so hopefully your changes should not be tracked by git.

## Tweaking the results

If you want to change the width of the filter for your search results, change the `WEDGE_WIDTH` in the `ResultModel.m`.