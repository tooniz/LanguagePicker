//
//  ViewController.h
//  LanguagePicker
//
//  Created by Tony Zhou on 5/28/14.
//  Copyright (c) 2014 Equippd Software. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EqpLanguagePicker.h"

@interface ViewController : UIViewController <EqpLanguagePickerDelegate>

@property (weak, nonatomic) IBOutlet UILabel *languagePicked;
@property (weak, nonatomic) IBOutlet EqpLanguagePicker *languagePicker;

- (IBAction)isoCodes:(id)sender;
- (IBAction)supportedList:(id)sender;
@end
