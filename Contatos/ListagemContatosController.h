//
//  ListagemContatosController.h
//  Contatos
//
//  Created by ios2602 on 12/04/14.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MessageUI/MFMailComposeViewController.h>
#import "Contato.h"
#import "ContatoProtocol.h"

@interface ListagemContatosController : UITableViewController <ContatoProtocol, UIActionSheetDelegate, MFMailComposeViewControllerDelegate>
@property (strong, nonatomic) NSMutableArray *contatos;

@end
