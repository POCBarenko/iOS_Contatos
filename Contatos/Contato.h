//
//  Contato.h
//  Contatos
//
//  Created by ios2602 on 12/04/21.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Contato : NSObject
@property (nonatomic, strong) NSString *nome;
@property (nonatomic, strong) NSString *email;
@property (nonatomic, strong) NSString *telefone;
@property (nonatomic, strong) NSString *endereco;
@property (nonatomic, strong) NSString *site;

- (id)initWithDictionary:(NSDictionary *) dictionary;
@end
