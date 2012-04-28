//
//  ListagemContatosController.m
//  Contatos
//
//  Created by ios2602 on 12/04/14.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ListagemContatosController.h"
#import "Contato.h"
#import "FormContatoController.h"
#import "EditFormContatoController.h"


@implementation ListagemContatosController
{
    Contato *selectedContact;
}

@synthesize contatos;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
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

    UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(showOptions:)];
    [self.tableView addGestureRecognizer:longPress];
    
    self.title = @"Contatos";
    
    self.navigationItem.leftBarButtonItem = self.editButtonItem;
        
    UIBarButtonItem *add = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(showForm)];
    self.navigationItem.rightBarButtonItem = add;
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

-(void)showOptions:(UIGestureRecognizer *)gesture
{
    if(gesture.state ==UIGestureRecognizerStateBegan){
        CGPoint point = [gesture locationInView:self.tableView];
        NSIndexPath *index = [self.tableView indexPathForRowAtPoint:point];
        selectedContact = [self.contatos objectAtIndex:index.row];
    
        UIActionSheet *options = [[UIActionSheet alloc] initWithTitle:selectedContact.nome delegate:self cancelButtonTitle:@"cancelar" destructiveButtonTitle:nil otherButtonTitles:@"Ligar", @"Enviar E-mail", @"Visualizar Site", @"Exibir Mapa", nil];
        [options showInView:self.tableView];
    }
}

-(void)showForm
{
    FormContatoController *form = [[FormContatoController alloc]initWithNibName:@"FormContatoController" bundle: [NSBundle mainBundle]];
    
    form.delegate = self;
    
    UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:form];

    [self presentModalViewController:nav animated: YES];
    
    
}

-(void) openURL:(NSString *) url
{
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:url]];
}

-(void) call:(Contato *)c{
    UIDevice *device = [UIDevice currentDevice]; 
    if ([device.model isEqualToString:@"iPhone"]){
        NSString *url = [NSString stringWithFormat:@"tel:%@", c.telefone];
        [self openURL:url];
    } else {
        [[[UIAlertView alloc]initWithTitle:@"Alerta" message:@"Seu dispositivo nao suporta ligacoes" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil] show];
    }
        
}

-(void) siteView:(Contato *)c{
    [self openURL:c.site];
}

-(void) openMap:(Contato *)c{
    NSString *url = [[NSString stringWithFormat:@"http://maps.google.com/maps?q=%@", c.endereco] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    [self openURL:url];
}

-(void) sendMail:(Contato *)c{
    if ([MFMailComposeViewController canSendMail]) {
        MFMailComposeViewController *sender = [[MFMailComposeViewController alloc] init];
        sender.mailComposeDelegate = self;
        
        [sender setToRecipients:[NSArray arrayWithObject:selectedContact.email]];
        [sender setSubject:@"Caelum"];
        
        [self presentModalViewController:sender animated:YES];
    }else{
        [[[UIAlertView alloc]initWithTitle:@"Ops" message:@"Nao pode enviar email" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil] show];
    }
}

-(void) mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error{
    [self dismissModalViewControllerAnimated:YES];
}

-(void) actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)index
{
    switch (index) {
        case 0:
            [self call:selectedContact];
            break;
        case 1:
            [self sendMail:selectedContact];
            break;
        case 2:
            [self siteView:selectedContact];
            break;
        case 3:
            [self openMap:selectedContact];
            break;
        default:
            break;
    }
}

-(void) addContact:(Contato *)contato
{
    [self.contatos addObject:contato];
    [self.tableView reloadData];
}

-(void) savedContact
{
    [self.tableView reloadData];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [contatos count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    // recicla celulas para economizar memoria
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    
    // Configure the cell...
    Contato *contato = [contatos objectAtIndex:[indexPath row]];
    cell.textLabel.text = [contato nome];
    cell.detailTextLabel.text = [contato email];
    
    return cell;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/


// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (editingStyle) {
        case UITableViewCellEditingStyleDelete:
            [self.contatos removeObjectAtIndex:indexPath.row];
            
            [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
            break;
        case UITableViewCellEditingStyleInsert:
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
            break;
        default:
            break;
    }
}


/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.
    Contato *c = [self.contatos objectAtIndex:indexPath.row];
    EditFormContatoController *form = [[EditFormContatoController alloc] initWithContato:c];
    form.delegate = self;
     // Pass the selected object to the new view controller.
    [self.navigationController pushViewController:form animated:YES];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end
