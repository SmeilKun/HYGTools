//
//  UIImage+HYGExtension.m
//  HYGToolKit
//
//  Created by 胡亚刚 on 2017/7/11.
//  Copyright © 2017年 hu yagang. All rights reserved.
//

#import "UIImage+HYGExtension.h"

@implementation UIImage (HYGExtension)

- (UIImage *)hyg_imageAddCornerWithRadius:(CGFloat)radius andSize:(CGSize)size{
    CGRect rect = CGRectMake(0, 0, size.width, size.height);

    UIGraphicsBeginImageContextWithOptions(size, NO, [UIScreen mainScreen].scale);
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    UIBezierPath * path = [UIBezierPath bezierPathWithRoundedRect:rect byRoundingCorners:UIRectCornerAllCorners cornerRadii:CGSizeMake(radius, radius)];
    CGContextAddPath(ctx,path.CGPath);
    CGContextClip(ctx);
    [self drawInRect:rect];
    CGContextDrawPath(ctx, kCGPathFillStroke);
    UIImage * newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}

+ (UIImage *)hyg_imageWithColor:(UIColor *)color {

    CGRect rect = CGRectMake(0, 0, 3, 3);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage * img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return img;
}

//生成缩略图
+ (UIImage *)hyg_image:(UIImage *)image fillSize:(CGSize)viewSize
{
    CGSize size = image.size;

    CGFloat scaleX = viewSize.width / size.width;
    CGFloat scaleY = viewSize.height / size.height;
    CGFloat scale = MAX(scaleX, scaleY);

    UIGraphicsBeginImageContext(viewSize);

    CGFloat width = size.width * scale;
    CGFloat height = size.height * scale;

    float dWidth = ((viewSize.width - width) / 2.0f);
    float dHeight = ((viewSize.height - height) / 2.0f);

    CGRect rect = CGRectMake(dWidth, dHeight, size.width * scale, size.height * scale);
    [image drawInRect:rect];

    UIImage *newImg = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();

    return newImg;
}

- (UIImage *)hyg_resizableImageWithCapInsets:(CGFloat)capInsets resizingMode:(UIImageResizingMode)resizingMode {
    CGFloat top = self.size.height * capInsets;
    CGFloat left = self.size.width * capInsets;
    CGFloat bottom = self.size.height * capInsets;
    CGFloat right = self.size.width * capInsets;
    UIEdgeInsets edgeInsets = UIEdgeInsetsMake(top, left, bottom, right);
    return [self resizableImageWithCapInsets:edgeInsets resizingMode:resizingMode];
}


- (UIImage *)fixOrientation {

    // No-op if the orientation is already correct
    if (self.imageOrientation == UIImageOrientationUp) return self;

    // We need to calculate the proper transformation to make the image upright.
    // We do it in 2 steps: Rotate if Left/Right/Down, and then flip if Mirrored.
    CGAffineTransform transform = CGAffineTransformIdentity;

    switch (self.imageOrientation) {
        case UIImageOrientationDown:
        case UIImageOrientationDownMirrored:
            transform = CGAffineTransformTranslate(transform, self.size.width, self.size.height);
            transform = CGAffineTransformRotate(transform, M_PI);
            break;

        case UIImageOrientationLeft:
        case UIImageOrientationLeftMirrored:
            transform = CGAffineTransformTranslate(transform, self.size.width, 0);
            transform = CGAffineTransformRotate(transform, M_PI_2);
            break;

        case UIImageOrientationRight:
        case UIImageOrientationRightMirrored:
            transform = CGAffineTransformTranslate(transform, 0, self.size.height);
            transform = CGAffineTransformRotate(transform, -M_PI_2);
            break;
        case UIImageOrientationUp:
        case UIImageOrientationUpMirrored:
            break;
    }

    switch (self.imageOrientation) {
        case UIImageOrientationUpMirrored:
        case UIImageOrientationDownMirrored:
            transform = CGAffineTransformTranslate(transform, self.size.width, 0);
            transform = CGAffineTransformScale(transform, -1, 1);
            break;

        case UIImageOrientationLeftMirrored:
        case UIImageOrientationRightMirrored:
            transform = CGAffineTransformTranslate(transform, self.size.height, 0);
            transform = CGAffineTransformScale(transform, -1, 1);
            break;
    }

    // Now we draw the underlying CGImage into a new context, applying the transform
    // calculated above.
    CGContextRef ctx = CGBitmapContextCreate(NULL, self.size.width, self.size.height,
                                             CGImageGetBitsPerComponent(self.CGImage), 0,
                                             CGImageGetColorSpace(self.CGImage),
                                             CGImageGetBitmapInfo(self.CGImage));
    CGContextConcatCTM(ctx, transform);
    switch (self.imageOrientation) {
        case UIImageOrientationLeft:
        case UIImageOrientationLeftMirrored:
        case UIImageOrientationRight:
        case UIImageOrientationRightMirrored:
            // Grr...
            CGContextDrawImage(ctx, CGRectMake(0,0,self.size.height,self.size.width), self.CGImage);
            break;

        default:
            CGContextDrawImage(ctx, CGRectMake(0,0,self.size.width,self.size.height), self.CGImage);
            break;
    }

    // And now we just create a new UIImage from the drawing context
    CGImageRef cgimg = CGBitmapContextCreateImage(ctx);
    UIImage *img = [UIImage imageWithCGImage:cgimg];
    CGContextRelease(ctx);
    CGImageRelease(cgimg);
    return img;
}


- (UIImage *)croppedImage {

    UIImage *image = [self fixOrientation];
    UIImage *thumbnail = image;

    CGFloat w = image.size.width;
    CGFloat h = image.size.height;
    CGFloat sw = w > h ? 1920.f : 1080.f;
    CGFloat sh = w > h ? 1080.f : 1920.f;
    if (!(sw >= w || sh >= h)) {

        CGFloat scale = MIN(sw / w, sh / h);

        CGSize imageSize = CGSizeMake(w * scale, h * scale);
        if (w != imageSize.width || h != imageSize.height) {

            UIGraphicsBeginImageContext(imageSize);
            CGRect imageRect = CGRectMake(0.0, 0.0, imageSize.width, imageSize.height);
            [image drawInRect:imageRect];
            thumbnail = UIGraphicsGetImageFromCurrentImageContext();
            UIGraphicsEndImageContext();
        }
    }

    return thumbnail;
}

@end
