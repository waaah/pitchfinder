#import "PitchdetectorPlugin.h"
#import <pcm16khz_audio_recorder/pcm16khz_audio_recorder-Swift.h>

@implementation PitchdetectorPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  // FlutterMethodChannel* channel = [FlutterMethodChannel
  //     methodChannelWithName:@"pitchdetector"
  //           binaryMessenger:[registrar messenger]];
  // PitchdetectorPlugin* instance = [[PitchdetectorPlugin alloc] init];
  // [registrar addMethodCallDelegate:instance channel:channel];
  [PitchDetectorPlugin registerWithRegistrar:registrar]

}

// - (void)handleMethodCall:(FlutterMethodCall*)call result:(FlutterResult)result {
//   if ([@"getPlatformVersion" isEqualToString:call.method]) {
//     result([@"iOS " stringByAppendingString:[[UIDevice currentDevice] systemVersion]]);
//   } else {
//     result(FlutterMethodNotImplemented);
//   }
// }

@end
