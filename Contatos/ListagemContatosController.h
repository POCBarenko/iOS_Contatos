//
//  ListagemContatosController.h
//  Contatos
//
//  Created by ios2602 on 12/04/14.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Contato.h"
#import "ContatoProtocol.h"

@interface ListagemContatosController : UITableViewController <ContatoProtocol>
@property (strong, nonatomic) NSMutableArray *contatos;

@end
