LanguagePicker
==============

A language picker using UIPickerView from iOS7+. It is fully localized, can be used as a default list of languages or a supported list of languages.

All languages are based on ISO 639 language code standard (http://en.wikipedia.org/wiki/List_of_ISO_639-1_codes)

Supported iOS & SDK Versions
-----------------------------

* Supported build target - iOS 7.0 (Xcode 5.0, Apple LLVM compiler 5.0)
* Earliest supported deployment target - iOS 5.0
* Earliest compatible deployment target - iOS 4.3

NOTE: 'Supported' means that the library has been tested with this version. 'Compatible' means that the library should work on this iOS version (i.e. it doesn't rely on any unavailable SDK features) but is no longer being tested for compatibility and may require tweaking or bug fixes to run correctly.


ARC Compatibility
------------------

As of version 1.1, LanguagePicker requires ARC. If you wish to use LanguagePicker in a non-ARC project, just add the -fobjc-arc compiler flag to the LanguagePicker.m file. To do this, go to the Build Phases tab in your target settings, open the Compile Sources group, double-click LanguagePicker.m in the list and type -fobjc-arc into the popover.

If you wish to convert your whole project to ARC, comment out the #error line in LanguagePicker.m, then run the Edit > Refactor > Convert to Objective-C ARC... tool in Xcode and make sure all files that you wish to use ARC for (including LanguagePicker.m) are checked.

Installation
--------------

To use the LanguagePicker in an app, just drag the LanguagePicker class files, and the Countries.plist file into your project.

LanguagePicker instance methods
----------------------------------

    - (void)setSelectedLanguageCode:(NSString *)countryCode animated:(BOOL)animated;
    - (void)setSelectedLanguageName:(NSString *)countryName animated:(BOOL)animated;
    - (void)setSelectedLocale:(NSLocale *)locale animated:(BOOL)animated;
    
These methods allow you to set the current country via name, code or locale. THey work excatly like the equivalent property setters, but have an optional animated parameter to make the picker scroll smoothly to the selected country.


LanguagePickerDelegate protocol
--------------------------------

The LanguagePickerDelegate protocol has a single obligatory method:

	- (void)countryPicker:(LanguagePicker *)picker didSelectLanguageWithName:(NSString *)name code:(NSString *)code;

This method is called whenever a country is selected in the picker.

Acknowledgement
--------------------------------
This project is based on CountryPicker by Nick Lockwood (https://github.com/nicklockwood/CountryPicker)
