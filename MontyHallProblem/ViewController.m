//
//  ViewController.m
//  MontyHallProblem
//
//  Created by Jo Tu on 7/25/16.
//  Copyright © 2016 Turn To Tech. All rights reserved.
//


#define ARC4RANDOM_MAX      0x100000000

#import "ViewController.h"

@interface ViewController ()
@property (nonatomic,weak) NSString *firstDoor;
@property (nonatomic,weak) NSString *secondDoor;
@property (nonatomic,weak) NSString *thirdDoor;
@property (nonatomic,weak) NSString *choice;
@property (nonatomic,strong) NSMutableArray *doorChoices;
@property (nonatomic,weak) NSString *montysDoor; //always a mofking GOAT
@property(nonatomic) int pickOtherDoorAndWonCar;
@property(nonatomic) int stickWithDoorAndWonCar;



@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    for(int i = 0; i < 10000; i++){
        [self alwaysPickOtherDoor];
        if([self.choice isEqualToString:@"Car"]){
            self.pickOtherDoorAndWonCar++;
            
        }
        
           }
    
    
    
    for(int i = 0; i < 10000; i++){

        [self randomlySelectDoor];
        if([self.choice isEqualToString:@"Car"]){
            self.stickWithDoorAndWonCar++;
            
        }
        
      
        
    }
    NSLog(@"always switching door when Monty shows goat is shown wins car %i out of 10000 times",self.pickOtherDoorAndWonCar);
    NSLog(@"always sticking with door when Monty shows goat is shown wins car %i out of 10000 times",self.stickWithDoorAndWonCar);

    
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



-(void)alwaysPickOtherDoor{
    
    NSString *doorOpened = [self doorMontyisOffering];
    if([self.choice isEqualToString:@"Car"] && [doorOpened isEqualToString:@"Goat1"]){
        self.choice = @"Goat2";
        
    }
    
   else if([self.choice isEqualToString:@"Car"] && [doorOpened isEqualToString:@"Goat2"]){
        self.choice = @"Goat1";
        
    }
    
   else if([self.choice isEqualToString:@"Goat1"] && [doorOpened isEqualToString:@"Goat2"]){
        self.choice = @"Car";
        
    }
    
    else if([self.choice isEqualToString:@"Goat2"] && [doorOpened isEqualToString:@"Goat1"]){
        self.choice = @"Car";
        
    }

}
-(NSString*)doorMontyisOffering{
    [self randomlySelectDoor];


    if([self.choice isEqualToString:@"Car"]){
        double randomVal = [self returnRandomValueBetweenZeroAndOne];
        if(randomVal <= 0.5){  //if you selected a car, monty always offerse a goat
            self.montysDoor = @"Goat1";
        }
        
        else if(randomVal > 0.5){
            self.montysDoor=@"Goat2";
        }
    }
    else if([self.choice isEqualToString:@"Goat1"]){
        self.montysDoor = @"Goat2";
    }
    
    else if([self.choice isEqualToString:@"Goat2"]){
        self.montysDoor = @"Goat1";
    } //when monty oipens a door, he elimminates a goat no matter what
    
    //depending on what goat he opens.you can narrow down what door to open
    
    
    return self.montysDoor;

}


-(void)randomlySelectDoor{
    [self randomizeDoors];

    double selectionRandomizer = [self returnRandomValueBetweenZeroAndOne];
    if(selectionRandomizer <= 0.33){
        self.choice = self.firstDoor;
    }
    else if(selectionRandomizer > 0.33 && selectionRandomizer <= 0.66){
        self.choice = self.secondDoor;

    }
    
    else
    {
        self.choice = self.thirdDoor;

    }
    
//    NSLog(@"%@",self.choice);
}




-(void)randomizeDoors{
    
    NSMutableArray *doors = [[NSMutableArray alloc]init];
    double doorRandomizer = [self returnRandomValueBetweenZeroAndOne];
    
    if(doorRandomizer <= 0.33){
        [doors addObject:@"Car"];
        [doors addObject:@"Goat1"];
        [doors addObject:@"Goat2"];
    }
   else if(doorRandomizer > 0.33 && doorRandomizer <= 0.66){
       [doors addObject:@"Goat1"];
       [doors addObject:@"Car"];
        [doors addObject:@"Goat2"];
    }
    
   else
      {
           [doors addObject:@"Goat1"];
           [doors addObject:@"Goat2"];
           [doors addObject:@"Car"];
       }
    
    self.doorChoices =  [[NSMutableArray alloc]init];
    self.firstDoor=doors[0];
    self.secondDoor=doors[1];
    self.thirdDoor=doors[2];
    [self.doorChoices addObject:self.firstDoor];
    [self.doorChoices addObject:self.secondDoor];
    [self.doorChoices addObject:self.thirdDoor];
    
    
    //add doors in array so that
    
    
    

    
}




-(double)returnRandomValueBetweenZeroAndOne{
    
    double val = ((double)arc4random() / ARC4RANDOM_MAX);
    return val;
    
    //return should be handled to determine bool
}
@end
