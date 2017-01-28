//
//  Person.m
//  Sandbox
//
//  Created by Djuro Alfirevic on 12/3/16.
//  Copyright © 2016 Djuro Alfirevic. All rights reserved.
//

#import "Person.h"

@interface Person()
@property (nonatomic) NSInteger brojLicneKarte;
@end

@implementation Person

#pragma mark - Public API

- (void)predstaviSe {
    NSLog(@"Ja sam %@ %@", self.ime, self.prezime);
}

- (void)kaziStanjeRacuna {
    NSLog(@"Stanje racuna: %f", self.racun);
}

- (void)kupiArtikal:(CGFloat)cena {
    if (self.racun > cena) {
        self.racun = self.racun - cena;
    }
}

#pragma mark - Private API

- (void)privatnaMetoda {
    NSLog(@"Bla bla");
}

@end
