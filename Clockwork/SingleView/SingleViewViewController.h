//
//  SingleViewViewController.h
//  SingleView
//
//  Created by AllenLin on 12/12/12.
//  Copyright (c) 2012 AllenLin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import <QuartzCore/CAAnimation.h>
#import <AudioToolbox/AudioToolbox.h>
#import <AudioToolbox/AudioServices.h>

@interface SingleViewViewController : UIViewController
- (void)spinLayer:(CALayer *)inLayer duration:(CFTimeInterval)inDuration
        direction:(int)direction byDegree:(float)degree;

@property (readonly)	SystemSoundID	soundFileObject;

@end
