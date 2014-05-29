//
//  EqpLanguagePicker.m
//  TapTapTranslate
//
//  Created by Tony Zhou on 5/25/14.
//  Copyright (c) 2014 Equippd Software. All rights reserved.
//

#import "EqpLanguagePicker.h"
#import <Availability.h>
#if !__has_feature(objc_arc)
#error This class requires automatic reference counting
#endif

@interface EqpLanguagePicker () <UIPickerViewDelegate, UIPickerViewDataSource>

@end

@implementation EqpLanguagePicker

//doesn't use _ prefix to avoid name clash
@synthesize delegate;

- (NSArray *)languageNames
{
    if (!_languageNames)
    {
        _languageNames = [[[self.languageNamesByCode allValues] sortedArrayUsingSelector:@selector(caseInsensitiveCompare:)] copy];
    }
    return _languageNames;
}

- (NSArray *)languageCodes
{
    if (!_languageCodes)
    {
        _languageCodes = [[self.languageCodesByName objectsForKeys:self.languageNames notFoundMarker:@""] copy];
    }
    return _languageCodes;
}

- (NSDictionary *)languageNamesByCode
{
    if (!_languageNamesByCode)
    {
        NSMutableDictionary *namesByCode = [NSMutableDictionary dictionary];
        for (NSString *code in [NSLocale ISOLanguageCodes])
        {
            if ((!self.supportedCodes) || ([self.supportedCodes containsObject:code])) {
                NSString *identifier = [NSLocale localeIdentifierFromComponents:@{NSLocaleLanguageCode: code}];
                NSString *LanguageName = [[NSLocale currentLocale] displayNameForKey:NSLocaleIdentifier value:identifier];
                if (LanguageName) namesByCode[code] = LanguageName;
            }
        }
        _languageNamesByCode = [namesByCode copy];
    }
    return _languageNamesByCode;
}

- (NSDictionary *)languageCodesByName
{
    if (!_languageCodesByName)
    {
        NSDictionary *namesByCode = self.languageNamesByCode;
        NSMutableDictionary *codesByName = [NSMutableDictionary dictionary];
        for (NSString *code in namesByCode)
        {
            codesByName[namesByCode[code]] = code;
        }
        _languageCodesByName = [codesByName copy];
    }
    return _languageCodesByName;
}

- (void)setup
{
    [super setDataSource:self];
    [super setDelegate:self];
}

- (id)initWithFrame:(CGRect)frame
{
    if ((self = [super initWithFrame:frame]))
    {
        [self setup];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    if ((self = [super initWithCoder:aDecoder]))
    {
        [self setup];
    }
    return self;
}

- (void)setDataSource:(__unused id<UIPickerViewDataSource>)dataSource
{
    //does nothing
}

- (void)setSelectedLanguageCode:(NSString *)languageCode animated:(BOOL)animated
{
    NSInteger index = [self.languageCodes indexOfObject:languageCode];
    if (index != NSNotFound)
    {
        [self selectRow:index inComponent:0 animated:animated];
    }
}

- (void)setSelectedLanguageCode:(NSString *)languageCode
{
    [self setSelectedLanguageCode:languageCode animated:NO];
}

- (NSString *)selectedLanguageCode
{
    NSInteger index = [self selectedRowInComponent:0];
    return self.languageCodes[index];
}

- (void)setSelectedLanguageName:(NSString *)languageName animated:(BOOL)animated
{
    NSInteger index = [self.languageNames indexOfObject:languageName];
    if (index != NSNotFound)
    {
        [self selectRow:index inComponent:0 animated:animated];
    }
}

- (void)setSelectedLanguageName:(NSString *)languageName
{
    [self setSelectedLanguageName:languageName animated:NO];
}

- (NSString *)selectedLanguageName
{
    NSInteger index = [self selectedRowInComponent:0];
    return self.languageNames[index];
}

- (void)setSelectedLocale:(NSLocale *)locale animated:(BOOL)animated
{
    [self setSelectedLanguageCode:[locale objectForKey:NSLocaleLanguageCode] animated:animated];
}

- (void)setSelectedLocale:(NSLocale *)locale
{
    [self setSelectedLocale:locale animated:NO];
}

- (NSLocale *)selectedLocale
{
    NSString *LanguageCode = self.selectedLanguageCode;
    if (LanguageCode)
    {
        NSString *identifier = [NSLocale localeIdentifierFromComponents:@{NSLocaleLanguageCode: LanguageCode}];
        return [NSLocale localeWithLocaleIdentifier:identifier];
    }
    return nil;
}

#pragma mark -
#pragma mark UIPicker

- (NSInteger)numberOfComponentsInPickerView:(__unused UIPickerView *)pickerView
{
    return 1;
}

- (NSInteger)pickerView:(__unused UIPickerView *)pickerView numberOfRowsInComponent:(__unused NSInteger)component
{
    return [self.languageCodes count];
}

- (UIView *)pickerView:(__unused UIPickerView *)pickerView viewForRow:(NSInteger)row
          forComponent:(__unused NSInteger)component reusingView:(UIView *)view
{
    NSUInteger width = [[UIScreen mainScreen] bounds].size.width;
    if (!view)
    {
        view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, width, 40)];
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 3, width, 34)];
        label.backgroundColor = [UIColor clearColor];
        label.tag = 1;
        label.textAlignment = NSTextAlignmentCenter;
        [view addSubview:label];
        
//        UIImageView *flagView = [[UIImageView alloc] initWithFrame:CGRectMake(3, 3, 24, 24)];
//        flagView.contentMode = UIViewContentModeScaleAspectFit;
//        flagView.tag = 2;
//        [view addSubview:flagView];
    }
    
    ((UILabel *)[view viewWithTag:1]).text = self.languageNames[row];
//    ((UIImageView *)[view viewWithTag:2]).image = [UIImage imageNamed:[[self class] LanguageCodes][row]];
    
    return view;
}

- (void)pickerView:(__unused UIPickerView *)pickerView
      didSelectRow:(__unused NSInteger)row
       inComponent:(__unused NSInteger)component
{
    [delegate EqpLanguagePicker:self didSelectLanguageWithName:self.selectedLanguageName code:self.selectedLanguageCode];
}

- (void)reloadAllComponents {
    [self resetLanguages];
    [super reloadAllComponents];
}

- (void)resetLanguages {
    _languageCodes = nil;
    _languageCodesByName = nil;
    _languageNames = nil;
    _languageNamesByCode = nil;
}

@end
