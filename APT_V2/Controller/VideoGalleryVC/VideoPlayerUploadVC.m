//
//  VideoPlayerUploadVC.m
//  APT_V2
//
//  Created by Apple on 09/02/18.
//  Copyright © 2018 user. All rights reserved.
//

#import "VideoPlayerUploadVC.h"

@interface VideoPlayerUploadVC ()

@end

@implementation VideoPlayerUploadVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.shadowView.layer.cornerRadius = 2.0f;
    self.shadowView.layer.borderWidth = 1.0f;
    self.shadowView.layer.borderColor = [UIColor lightGrayColor].CGColor;
    self.shadowView.layer.masksToBounds = YES;

//    self.shadowView.layer.shadowColor = [UIColor lightGrayColor].CGColor;
//    self.shadowView.layer.shadowOffset = CGSizeMake(5, 5.0f);
//    self.shadowView.layer.shadowRadius = 2.0f;
//    self.shadowView.layer.shadowOpacity = 1.0f;
//    self.shadowView.layer.masksToBounds = NO;
//    self.shadowView.layer.shadowPath = [UIBezierPath bezierPathWithRoundedRect:self.shadowView.bounds cornerRadius:self.shadowView.layer.cornerRadius].CGPath;
    
    self.teamView.layer.borderColor = [UIColor lightGrayColor].CGColor;
    self.teamView.layer.borderWidth = 1.0f;
    
    self.playerView.layer.borderColor = [UIColor lightGrayColor].CGColor;
    self.playerView.layer.borderWidth = 1.0f;
    
    self.videoDateView.layer.borderColor = [UIColor lightGrayColor].CGColor;
    self.videoDateView.layer.borderWidth = 1.0f;
    
    self.CategoryView.layer.borderColor = [UIColor lightGrayColor].CGColor;
    self.CategoryView.layer.borderWidth = 1.0f;
    
    self.keywordsView.layer.borderColor = [UIColor lightGrayColor].CGColor;
    self.keywordsView.layer.borderWidth = 1.0f;
    
    self.sharetoUserView.layer.borderColor = [UIColor lightGrayColor].CGColor;
    self.sharetoUserView.layer.borderWidth = 1.0f;

}



@end
