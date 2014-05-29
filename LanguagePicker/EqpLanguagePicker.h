//
//  EqpLanguagePicker.h
//  TapTapTranslate
//
//  Created by Tony Zhou on 5/25/14.
//  Copyright (c) 2014 Equippd Software. All rights reserved.
//

#import <UIKit/UIKit.h>
#undef weak_delegate
#if __has_feature(objc_arc_weak)
#define weak_delegate weak
#else
#define weak_delegate unsafe_unretained
#endif

@class EqpLanguagePicker;

@protocol EqpLanguagePickerDelegate <UIPickerViewDelegate>
- (void)EqpLanguagePicker:(EqpLanguagePicker *)picker didSelectLanguageWithName:(NSString *)name code:(NSString *)code;
@end

@interface EqpLanguagePicker : UIPickerView

@property (nonatomic, strong) NSArray *supportedCodes;
@property (nonatomic, strong) NSArray *languageNames;
@property (nonatomic, strong) NSArray *languageCodes;
@property (nonatomic, strong) NSDictionary *languageNamesByCode;
@property (nonatomic, strong) NSDictionary *languageCodesByName;

@property (nonatomic, weak_delegate) id<EqpLanguagePickerDelegate> delegate;

@property (nonatomic, copy) NSString *selectedLanguageName;
@property (nonatomic, copy) NSString *selectedLanguageCode;
@property (nonatomic, copy) NSLocale *selectedLocale;

- (void)setSelectedLanguageCode:(NSString *)languageCode animated:(BOOL)animated;
- (void)setSelectedLanguageName:(NSString *)languageName animated:(BOOL)animated;
- (void)setSelectedLocale:(NSLocale *)locale animated:(BOOL)animated;

@end
