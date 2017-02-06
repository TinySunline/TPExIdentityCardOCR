//
//  TPExIdentityCardOCRViewController.m
//  TPExIdentityCardOCR
//
//  Created by kingdomrain on 02/06/2017.
//  Copyright (c) 2017 kingdomrain. All rights reserved.
//

#import "TPExIdentityCardOCRViewController.h"
#import <TPExIdentityCardOCR/TPExIdentityCardOCR.h>


@interface TPExIdentityCardOCRViewController ()

@end

@implementation TPExIdentityCardOCRViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    TPExIdentityCardOCR *ocr = [[TPExIdentityCardOCR alloc] init];
    [ocr start];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
