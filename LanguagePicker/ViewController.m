//
//  ViewController.m
//  LanguagePicker
//
//  Created by Tony Zhou on 5/28/14.
//  Copyright (c) 2014 Equippd Software. All rights reserved.
//

#import "ViewController.h"

// List of supported languages in Microsoft Translator
#define kMSTranslateSupported \
@"ar",@"bg",@"ca",@"zh",@"zh-CHS",@"zh-CHT",@"cs", \
@"cy",@"da",@"nl",@"en",@"et",@"fi",@"fr",@"de", \
@"el",@"ht",@"he",@"hi",@"mww",@"hu",@"id",@"it", \
@"ja",@"tlh",@"tlh-Qaak",@"ko",@"lv",@"lt",@"ms", \
@"mt",@"no",@"fa",@"pl",@"pt",@"ro",@"ru",@"sk", \
@"sl",@"es",@"sv",@"th",@"tr",@"uk",@"ur",@"vi"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.languagePicker.delegate = self;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)isoCodes:(id)sender {
    self.languagePicker.supportedCodes = nil;
    [self.languagePicker reloadAllComponents];
}

- (IBAction)supportedList:(id)sender {
    // Note only the intersection of supportedCodes array and [NSLocal ISOLanguageCodes] array will end up being displayed
    // This way only NSLocale supported languages get used, may be confusing to the user but this way all names will be localized
    self.languagePicker.supportedCodes = [[NSArray alloc] initWithObjects:kMSTranslateSupported, nil];
    [self.languagePicker reloadAllComponents];
}

#pragma mark - EqpLanguagePicker Delegate Methods
- (void)EqpLanguagePicker:(EqpLanguagePicker *)picker didSelectLanguageWithName:(NSString *)name code:(NSString *)code
{
    self.languagePicked.text = name;
}

@end
