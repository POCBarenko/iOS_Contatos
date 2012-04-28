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
@synthesize botaoAdicionaImagem;
@synthesize textoAtual;

-(IBAction)focoNoTexto:(UITextField *)currentText {
    self.textoAtual = currentText;
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

- (void) escondeTeclado {
    if(self.textoAtual){
        [self.textoAtual resignFirstResponder];
        self.textoAtual = nil;
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"Cadastro";
    UIBarButtonItem *back = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemUndo target:self action:@selector(cancel)];
    self.navigationItem.leftBarButtonItem = back;

    UIBarButtonItem *add = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(add)];
    self.navigationItem.rightBarButtonItem = add;
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]
                                   initWithTarget:self action:@selector(escondeTeclado)];
    [self.view addGestureRecognizer:tap];
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
    c.imagem = self.botaoAdicionaImagem.imageView.image;
    
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
    [self setBotaoAdicionaImagem:nil];
    [super viewDidUnload];
    
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

-(IBAction)selecionaFoto:(id)sender{
    if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]){
        UIActionSheet *sheet = [[UIActionSheet alloc] initWithTitle:@"Escolha a foto do contato" delegate:self cancelButtonTitle:@"Cancelar" destructiveButtonTitle:nil otherButtonTitles:@"Tirar Foto", @"Escolher da biblioteca", nil];
        [sheet showInView:self.view];
    } else {
        UIImagePickerController *picker = [[UIImagePickerController alloc] init];
        picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        picker.allowsEditing=YES;
        picker.delegate = self;
        [self presentModalViewController:picker animated:YES];
    }
}

-(void) actionSheet:(UIActionSheet *)actionSheet didDismissWithButtonIndex:(NSInteger)buttonIndex{
    UIImagePickerController *picker = [[UIImagePickerController alloc]init];
    picker.delegate = self;
    picker.allowsEditing=YES;
    
    switch (buttonIndex) {
        case 0:
            picker.sourceType = UIImagePickerControllerSourceTypeCamera;
            break;
        case 1:
            picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
            break;            
            
        default:
            break;
    }
    [self presentModalViewController:picker animated:YES];
}

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    UIImage *image = [info valueForKey:UIImagePickerControllerEditedImage];
    [botaoAdicionaImagem setImage:image forState:UIControlStateNormal];
    [picker dismissModalViewControllerAnimated:YES];
}

@end
