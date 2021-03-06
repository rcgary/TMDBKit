//
//  TMDBMovie.m
//  TMDBKit
//
//  Created by Chao Ruan on 25/07/2015.
//  Copyright (c) 2015 Chao Ruan. All rights reserved.
//

#import "TMDBMovie.h"
#import "TMDBGenre.h"
#import "TMDBImage.h"
#import "TMDBVideo.h"
#import "TMDBImageResponse.h"
#import "TMDBVideoResponse.h"
#import "TMDBCreditsResponse.h"
#import "TMDBConstant.h"
#import <ReactiveCocoa/ReactiveCocoa.h>

@interface TMDBMovie ()
@property (nonatomic, copy) NSArray *posters;
@property (nonatomic, copy) NSArray *backdrops;
@property (nonatomic, copy) NSArray *videoKeys;
@property (nonatomic, copy) NSArray *casts;
@property (nonatomic, copy) NSArray *crews;
@end

@implementation TMDBMovie
+ (NSDictionary*)JSONKeyPathsByPropertyKey
{
  return [super.JSONKeyPathsByPropertyKey mtl_dictionaryByAddingEntriesFromDictionary:
          @{
            @"backdropPath": @"backdrop_path",
            @"genreIDs": @"genre_ids",
            @"originalLanguage": @"original_language",
            @"originalTitle": @"original_title",
            @"releaseDate": @"release_date",
            @"posterPath": @"poster_path",
            @"voteAverage": @"vote_average",
            @"voteCount": @"vote_count",
            @"title": @"title",
            @"popularityRate": @"popularity",
            @"overview": @"overview",
            @"imdbID": @"imdb_id",
            @"runtime": @"runtime",
            
            }];
}

+ (NSValueTransformer*)genresJSONTransformer
{
    return [MTLJSONAdapter arrayTransformerWithModelClass:TMDBGenre.class];
}

- (void)updateWithImageResponse:(TMDBImageResponse*)response
{
    self.backdrops = [[response.backdrops.rac_sequence map:^id(TMDBImage *image) {
        NSString *url = [NSString stringWithFormat:@"%@%@",tmdb_imageBaseURLDomain,image.filePath];
        return [NSURL URLWithString:url];
    }]array];
    
    self.posters = [[response.posters.rac_sequence map:^id(TMDBImage *image) {
        NSString *url = [NSString stringWithFormat:@"%@%@",tmdb_imageBaseURLDomain,image.filePath];
        return [NSURL URLWithString:url];
    }]array];
}

- (void)updateWithVideoResponse:(TMDBVideoResponse *)response
{
    self.videoKeys = [[response.videos.rac_sequence map:^id(TMDBVideo *video) {
        return video.key;
    }]array];

}
- (void)updateWithCreditResponse:(TMDBCreditsResponse *)response
{
    self.crews = response.crews;
    self.casts = response.casts;
}
@end
