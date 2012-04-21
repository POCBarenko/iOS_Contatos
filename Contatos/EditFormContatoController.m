//
//  EditFormContatoController.m
//  Contatos
//
//  Created by ios2602 on 12/04/21.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "EditFormContatoController.h"
#import "Contato.h"

@interface EditFormContatoController() 
    @property(strong, nonatomic) Contato *contato;
-(void) loadFormWithContact;
@end


@implementation EditFormContatoController
@synthesize contato;

- (id) initWithContato:(Contato *)_contato
{
    self = [super initWithNibName:@"FormContatoController" bundle:nil];
    
    if(self){
        // custom initialization
        self.contato = _contato;
    }
    return self;
}

-(void) save{
    contato.nome = self.nome.text;
    contato.email = self.email.text;
    contato.telefone = self.telefone.text;
    contato.endereco = self.endereco.text;
    contato.site = self.site.text;
    
    [self.delegate savedContact];
    
    [self.navigationController popViewControllerAnimated:YES];
}

-(void) loadFormWithContact{
    self.nome.text = contato.nome;
    self.email.text = contato.email;
    self.telefone.text = contato.telefone;
    self.endereco.text = contato.endereco;
    self.site.text = contato.site;
}

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
    UIBarButtonItem *save = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemSave target:self action:@selector(save)];
    self.navigationItem.rightBarButtonItem = save;
    
    // Do any additional setup after loading the view from its nib.
    [self loadFormWithContact];
}

- (void)viewDidUnload
{
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
