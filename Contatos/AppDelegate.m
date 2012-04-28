//
//  AppDelegate.m
//  Contatos
//
//  Created by ios2602 on 12/04/14.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "AppDelegate.h"
#import "ListagemContatosController.h"
#import "Contato.h"


//Declaracao de categoria, tudo nela eh visivel apenas neste arquivo... (simula privado)
@interface AppDelegate(){
    NSMutableArray *contatos;
}
-(void) gravandoNoPlist;
-(void) carregandoDoPlist;
//@property (nonatomic, strong) UILabel *xpto;
@end




@implementation AppDelegate

@synthesize window = _window;
@synthesize navigationController = _navigationController;

-(void) gravandoNoPlist{
    NSMutableDictionary *listaDeContatos = [[NSMutableDictionary alloc] init];
    
    for (int i=0; i< contatos.count; i++) {
        Contato *c = [contatos objectAtIndex:i];
        NSMutableDictionary *d = [[NSMutableDictionary alloc]init];
        
        [d setValue:c.nome forKey:@"nome"];
        [d setValue:c.email forKey:@"email"];
        [d setValue:c.telefone forKey:@"telefone"];
        [d setValue:c.endereco forKey:@"endereco"];
        [d setValue:c.site forKey:@"site"];
        
        NSData *data = UIImageJPEGRepresentation(c.imagem, 1.0);
        [d setValue:data forKey:@"imagem"];
        
        [listaDeContatos setValue:d forKey:[NSString stringWithFormat:@"%i", i]];
    }
    
    NSString *caminho = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString *arquivo = [NSString stringWithFormat:@"%@/contatos.plist", caminho];
    [listaDeContatos writeToFile:arquivo atomically:YES];
}

-(void) carregandoDoPlist{
    NSMutableDictionary *arrayDeContatos;
    
    NSString *caminho;
    
    NSString *dir = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString *arquivo = [NSString stringWithFormat:@"%@/contatos.plist", dir];
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if([fileManager fileExistsAtPath:arquivo]){
        caminho = arquivo;
    } else {
        caminho = [[NSBundle mainBundle] pathForResource:@"contatos" ofType:@"plist"];
    }
    
    arrayDeContatos = [[NSMutableDictionary alloc] initWithContentsOfFile:caminho];
    contatos = [[NSMutableArray alloc]init];
    
    for(NSString *k in arrayDeContatos){
        Contato *c = [[Contato alloc] initWithDictionary:[arrayDeContatos objectForKey:k]];
        [contatos addObject:c];
    }
    
}

-(void) loadProperties{
    NSString *bundleFileName = [[NSBundle mainBundle] pathForResource:@"contatos" ofType:@"plist"];
    
    NSMutableDictionary *contatosDic = [NSMutableDictionary dictionaryWithContentsOfFile:bundleFileName];
    
    contatos = [[NSMutableArray alloc] init];
    for(NSString *key in contatosDic){
        NSDictionary *d = [contatosDic objectForKey:key];
        Contato *c = [[Contato alloc] initWithDictionary:d];
        [contatos addObject:c];
    }
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    /*
    Contato *caelumSP = [[Contato alloc] init];
    [caelumSP setNome:@"Caelum Unidade SP"];
    [caelumSP setEmail:@"contato@caelum.com.br"];
    
    NSLog(@"Contato: %@ - %@", [caelumSP nome], [caelumSP email]);
    
    Contato *caelumBSB = [[Contato alloc] init];
    [caelumBSB setNome:@"Caelum Unidade BSB"];
    [caelumBSB setEmail:@"contatobsb@caelum.com.br"];
    
    NSLog(@"Contato: %@ - %@", caelumSP.nome, caelumSP.email);
    */
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    self.window.backgroundColor = [UIColor whiteColor];
    
    [self loadProperties];

    [self carregandoDoPlist];

    ListagemContatosController *listaContatos = [[ListagemContatosController alloc] initWithNibName:@"ListagemContatosController" bundle:[NSBundle mainBundle]];

    listaContatos.contatos = contatos;
    
    self.navigationController = [[UINavigationController alloc] initWithRootViewController:listaContatos];
    
    
    self.window.rootViewController = self.navigationController;
    
    [self.window makeKeyAndVisible];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    /*
     Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
     Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
     */
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    [self gravandoNoPlist];
    /*
     Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
     If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
     */
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    /*
     Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
     */
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    /*
     Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
     */
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    [self gravandoNoPlist];
    /*
     Called when the application is about to terminate.
     Save data if appropriate.
     See also applicationDidEnterBackground:.
     */
}

@end
