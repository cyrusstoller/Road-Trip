//
//  YelpSearchParamsEnum.h
//  RoadTrip
//
//  Created by Cyrus Stoller on 1/10/11.
//  Copyright 2011 Cyrus Stoller. All rights reserved.
//

//matches with @genreTypes in SplashViewController.m
typedef enum{
	kOther,
	kAll,
	kFood,
	kGas,
	kBars,
	kBanks,
	kDrugstores,
	kCoffeeTea
} YelpCategoryType;

//matches with @distances in SplashViewController.m
typedef enum{
	kSmall, //less than one mile
	k1mile,
	k5miles,
	k10miles,
	k20miles,
	k50miles
} YelpMaxDistance;

//matches with @sortingPriority in SplashViewController.m
typedef	enum{
	kRatings,
	kDistance,
	kBestMatch
} YelpSortingPriority;

//matches with @direction in SpecificSearchViewController.m
//matches with @headingControl in SplashViewController.m
typedef enum{
	kCurrent, //based on old and new locations
	kCompass,
	kNorth,
	kEast,
	kSouth,
	kWest
} YelpDirection;

//max price
//matches with @priceControl in SplashViewController.m
//for when yelp add price to their API
typedef enum{
	kdollar1,
	kdollar2,
	kdollar3,
	kdollar4
} YelpPrice;