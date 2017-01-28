//
//  Person.h
//  Sandbox
//
//  Created by Djuro Alfirevic on 12/3/16.
//  Copyright © 2016 Djuro Alfirevic. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreGraphics/CoreGraphics.h>

@interface Person : NSObject
@property (nonatomic) NSInteger jmbg;
@property (strong, nonatomic) NSString *ime;
@property (strong, nonatomic) NSString *prezime;
@property (nonatomic) NSInteger godine;
@property (strong, nonatomic) NSDate *datumRodjenja;
@property (nonatomic) CGFloat racun;

- (void)predstaviSe;
- (void)kaziStanjeRacuna;
- (void)kupiArtikal:(CGFloat)cena;
@end
