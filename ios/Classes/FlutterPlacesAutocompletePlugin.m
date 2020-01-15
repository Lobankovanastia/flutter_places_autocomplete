#import "FlutterPlacesAutocompletePlugin.h"
#if __has_include(<flutter_places_autocomplete/flutter_places_autocomplete-Swift.h>)
#import <flutter_places_autocomplete/flutter_places_autocomplete-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "flutter_places_autocomplete-Swift.h"
#endif

@implementation FlutterPlacesAutocompletePlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftFlutterPlacesAutocompletePlugin registerWithRegistrar:registrar];
}
@end
