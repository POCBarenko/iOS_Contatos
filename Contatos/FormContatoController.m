//
//  FormContatoController.m
//  Contatos
//
//  Created by ios2602 on 12/04/21.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "FormContatoController.h"
#import "Contato.h"
#import "ListagemContatosController.h"
#import "ContatoProtocol.h"

@implementation FormContatoController
@synthesize delegate;
@synthesize nome;
@synthesize email;
@synthesize telefone;
@synthesize endereco;
@synthesize site;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"Cadastro";
    UIBarButtonItem *back = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemUndo target:self action:@selector(cancel)];
    self.navigationItem.leftBarButtonItem = back;

    UIBarButtonItem *add = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(add)];
    self.navigationItem.rightBarButtonItem = add;
}

-(void) cancel{
    [self dismissModalViewControllerAnimated:YES];
}
-(void) add{
    Contato *c = [[Contato alloc] init];
    c.nome = self.nome.text;
    c.email = self.email.text;
    c.telefone = self.telefone.text;
    c.endereco = self.endereco.text;
    c.site = self.site.text;
    
    [delegate addContact:c];
    
    [self dismissModalViewControllerAnimated:YES];
}

- (void)viewDidUnload
{
    [self setNome:nil];
    [self setEmail:nil];
    [self setTelefone:nil];
    [self setEndereco:nil];
    [self setSite:nil];
    [super viewDidUnload];
    
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
