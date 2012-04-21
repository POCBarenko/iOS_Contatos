//
//  ContatosProtocol.h
//  Contatos
//
//  Created by ios2602 on 12/04/21.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Contato.h"

@protocol ContatoProtocol <NSObject>
    -(void) addContact:(Contato *) contato;
    -(void) savedContact;
@end
