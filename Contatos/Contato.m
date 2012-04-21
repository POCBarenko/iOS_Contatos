//
//  Contato.m
//  Contatos
//
//  Created by ios2602 on 12/04/21.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "Contato.h"

@implementation Contato
@synthesize nome, email, telefone, endereco, site;


- (id)initWithDictionary:(NSDictionary *) dictionary
{
    self = [super init];
    if (self) {
        // Custom initialization
        [self setNome:[dictionary objectForKey:@"nome"]];
        [self setEmail:[dictionary objectForKey:@"email"]];
        [self setTelefone:[dictionary objectForKey:@"telefone"]];
        [self setEndereco:[dictionary objectForKey:@"endereco"]];
        [self setSite:[dictionary objectForKey:@"site"]];
    }
    return self;
}

@end
