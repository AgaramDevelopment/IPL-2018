//
//  UIImage+GetPoints.h
//  APT_V2
//
//  Created by user on 24/02/18.
//  Copyright © 2018 user. All rights reserved.
//

#import <UIKit/UIKit.h>

@implementation UIImage (GetPoints)


/*
 
 down vote
 accept
 Following method find the points of the color approximately(Swift 4):
 
 extension UIImage {
 func getPoints(displayP3Red: CGFloat, green: CGFloat, blue: CGFloat, alpha: CGFloat) -> [CGPoint] {
 var points = [CGPoint]()
 
 if let imageData = self.cgImage?.dataProvider?.data {
 let data: UnsafePointer<UInt8>  = CFDataGetBytePtr(imageData)
 let allowDiff:CGFloat = 0.015
 
 for x in 0 ..< Int(self.size.width) {
 for y in 0 ..< Int(self.size.height) {
 let pixelInfo: Int = ((Int(self.size.width) * y) + x) * 4
 
 let diffRed = CGFloat(data[pixelInfo]) / 255.0 - displayP3Red
 let diffGreen = CGFloat(data[pixelInfo+1]) / 255.0 - green
 let diffBlue = CGFloat(data[pixelInfo+2]) / 255.0 - blue
 let diffAlpha = CGFloat(data[pixelInfo+3]) / 255.0 - alpha
 
 if abs(diffRed) < allowDiff
 && abs(diffGreen) < allowDiff
 && abs(diffBlue) < allowDiff
 && abs(diffAlpha) < allowDiff { // compare the color approximately
 points.append(CGPoint(x: x, y: y))
 }
 }
 }
 }
 
 return points
 }
 }
 */

-(NSMutableArray *)getPointsfromRGB:(CGFloat)Red :(CGFloat)Green :(CGFloat)Blue andAlpha:(CGFloat)Alpha
{
    NSMutableArray* resultPoint = [NSMutableArray new];
    
    CFDataRef pixelData = CGDataProviderCopyData(CGImageGetDataProvider(self.CGImage));
    const UInt8* data = CFDataGetBytePtr(pixelData);
    CGFloat allowDiff = 0.015;
    
    for (int x=0; x<self.size.width; x++) {
        
        for (int y=0; y<self.size.height; y++) {
            
            int pixelInfo = ((self.size.width  * y) + x ) * 4; // The image is png
//            UInt8 red = (data[pixelInfo] / 255.0 ) - Red;
//            UInt8 green = (data[(pixelInfo + 1)] / 255.0) - Green;
//            UInt8 blue = (data[pixelInfo + 2] / 255.0) - Blue;
//            UInt8 alpha = (data[pixelInfo + 3] / 255.0) - Alpha;
//            if ((red) < allowDiff && (green) < allowDiff && (blue) < allowDiff && (alpha) < allowDiff) {
//                [resultPoint addObject:[NSValue valueWithCGPoint:CGPointMake(x, y)]];
//            }
            UInt8 red = (data[pixelInfo] / 255.0 );
            UInt8 green = (data[(pixelInfo + 1)] / 255.0);
            UInt8 blue = (data[pixelInfo + 2] / 255.0);
            UInt8 alpha = (data[pixelInfo + 3] / 255.0);

            
            if (red == Red && green == Green && blue == Blue && alpha == Alpha) {
                [resultPoint addObject:[NSValue valueWithCGPoint:CGPointMake(x, y)]];

            }
            
        }

    }
    
    return resultPoint;
}


/*
 CFDataRef pixelData = CGDataProviderCopyData(CGImageGetDataProvider(image.CGImage));
 const UInt8* data = CFDataGetBytePtr(pixelData);
 
 int pixelInfo = ((image.size.width  * y) + x ) * 4; // The image is png
 
 //UInt8 red = data[pixelInfo];         // If you need this info, enable it
 //UInt8 green = data[(pixelInfo + 1)]; // If you need this info, enable it
 //UInt8 blue = data[pixelInfo + 2];    // If you need this info, enable it
 UInt8 alpha = data[pixelInfo + 3];     // I need only this info for my maze game
 CFRelease(pixelData);
 
 //UIColor* color = [UIColor colorWithRed:red/255.0f green:green/255.0f blue:blue/255.0f alpha:alpha/255.0f]; // The pixel color info
 */
@end
