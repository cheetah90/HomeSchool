//
//  SingleViewViewController.m
//  SingleView
//
//  Created by AllenLin on 12/12/12.
//  Copyright (c) 2012 AllenLin. All rights reserved.
//
#define SPIN_CLOCK_WISE 1
#define SPIN_COUNTERCLOCK_WISE -1

#import "SingleViewViewController.h"

@interface SingleViewViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *gear1;
@property (weak, nonatomic) IBOutlet UIImageView *FixedGear1;
@property (weak, nonatomic) IBOutlet UIImageView *FixedGear2;



@end

@implementation SingleViewViewController

@synthesize gear1;
@synthesize FixedGear1;
@synthesize FixedGear2;
@synthesize soundFileObject;


- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    // Create the URL for the source audio file. The URLForResource:withExtension: method is
    //    new in iOS 4.0.
    NSURL *tapSound   = [[NSBundle mainBundle] URLForResource: @"spin"
                                                withExtension: @"mp3"];
    
    // Store the URL as a CFURLRef instance
    AudioServicesCreateSystemSoundID((__bridge CFURLRef) tapSound, &soundFileObject);
    

    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
	UITouch *touch = [[event allTouches] anyObject];
	CGPoint location = [touch locationInView:touch.view];
    self.gear1.center=location;
}

-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
	[self touchesBegan:touches withEvent:event];
}

-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
    int offset = 10;
    int CorrectX=129;
    int CorrectY=207;
    //If dropped at the correct location
    if (abs(CorrectX-self.gear1.center.x)<offset&&abs(CorrectY-self.gear1.center.y)<offset) {
        [self touchesBegan:touches withEvent:event];
        gear1.center= CGPointMake(129, 207);
        AudioServicesPlaySystemSound (soundFileObject);
        [self spinLayer:gear1.layer duration:3 direction:SPIN_CLOCK_WISE byDegree:2.0];
        [self spinLayer:FixedGear1.layer duration:3 direction:SPIN_COUNTERCLOCK_WISE byDegree:2.0];
        [self spinLayer:FixedGear2.layer duration:3 direction:SPIN_COUNTERCLOCK_WISE byDegree:1.0];

    } else {
        AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
        gear1.center= CGPointMake(78,361);
    }
    
}

- (void)spinLayer:(CALayer *)inLayer duration:(CFTimeInterval)inDuration
direction:(int)direction byDegree:(float)degree
{
    CABasicAnimation *rotationAnimation;
    
    // Rotate about the z axis
    rotationAnimation =[CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    
    // Rotate 360 degress, in direction specified
    rotationAnimation.toValue = [NSNumber numberWithFloat: M_PI * degree * direction];
    
    // Perform the rotation over this many seconds
    rotationAnimation.duration = inDuration;
    
    // Set the pacing of the animation
    rotationAnimation.timingFunction =
    [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    
    // Add animation to the layer and make it so
    [inLayer addAnimation:rotationAnimation forKey:@"rotationAnimation"];
}

@end
