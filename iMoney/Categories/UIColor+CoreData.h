//
//  UIColor+CoreData.h
//  iMoney
//
//  Created by Alex on 3/26/17.
//  Copyright © 2017 Ana Rotari. All rights reserved.
//

/*
 USAGE:
 
 var myColor = UIColor.green
 // Encoding the color to data
 let myColorData = myColor.encode() // This can be saved into coredata/UserDefaulrs
 let newColor = UIColor.color(withData: myColorData) // Converting back to UIColor from Data
 
 */

#import <UIKit/UIKit.h>

@interface UIColor (CoreData)

@end
