//
//  LPAVC.m
//  Login Page
//
//  Created by KaL on 8/12/14.
//  Copyright (c) 2014 Kalson Kalu. All rights reserved.
//

#import "LPAVC.h"

@interface LPAVC ()<UITextFieldDelegate>

@end

@implementation LPAVC

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        
        self.view.backgroundColor = [UIColor cyanColor];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    int rowCount = 4;
    int rowButtons = 2;
    int colCount = 5;
    int button = 2;
    
    for (int row = 0; row < rowCount; row++)
    {
        int spacing = 10;
    
        int y = (spacing + 40) * row;

        UITextField *textField = [[UITextField alloc]initWithFrame:CGRectMake(20, 20 + y, SCREEN_WIDTH - 40, 40)];
        textField.backgroundColor = [UIColor whiteColor];
        textField.layer.cornerRadius = 5;
        textField.delegate = self;
        [self.view addSubview:textField];
        
        UIView *paddingView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 10, 20)];
        textField.leftView = paddingView;
        textField.leftViewMode = UITextFieldViewModeAlways;
        
        switch (row) {
            case 0:
                textField.placeholder = @"Username";
                break;
            case 1:
                textField.placeholder = @"Password";
                textField.secureTextEntry = YES;
                break;
            case 2:
                textField.placeholder = @"Email";
                textField.keyboardType = UIKeyboardTypeEmailAddress;
                break;
            default:
                textField.placeholder = @"Phone Number";
                textField.keyboardType = UIKeyboardTypePhonePad;
                break;
        }
    }
    
    
    for (int row = 0; row < button; row++)
    {
        int spacing = 10;
        int y = (spacing + 40) * row;
        
        UIButton *buttons = [[UIButton alloc]initWithFrame:CGRectMake(20, 370 + y, SCREEN_WIDTH -40, 40)];
        buttons.backgroundColor = [UIColor whiteColor];
        [buttons setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        buttons.layer.cornerRadius = 5;
        [self.view addSubview:buttons];
        
        switch (row) {
            case 0:
                [buttons setTitle:@"Login" forState:UIControlStateNormal];
                buttons.backgroundColor = [UIColor redColor];
                break;
                
            default:
                [buttons setTitle:@"Reset" forState:UIControlStateNormal];
                buttons.backgroundColor = [UIColor orangeColor];
                break;
        }
        
    }
    for (int row = 0; row < rowButtons; row++) {
    
        for (int col = 0; col < colCount; col++)
        {
        
            int spacing = 15;
            
            int x = (spacing + 40) * col;
            int y = (spacing  + 30) * row;
            
            UIButton *colorButton = [[UIButton alloc]initWithFrame:CGRectMake(30 + x, 225 + y, 40, 40)];
            colorButton.layer.cornerRadius = 20;
            [self.view addSubview:colorButton];
            
            
            switch (col + (row * colCount)) {
                case 0:
                    colorButton.backgroundColor = [UIColor redColor];
                    break;
                case 1:
                    colorButton.backgroundColor = [UIColor orangeColor];
                    break;
                case 2:
                    colorButton.backgroundColor = [UIColor yellowColor];
                    break;
                case 3:
                    colorButton.backgroundColor = [UIColor greenColor];
                    break;
                case 4:
                    colorButton.backgroundColor = [UIColor blueColor];
                    break;
                case 5:
                    colorButton.backgroundColor = [UIColor blackColor];
                    break;
                case 6:
                    colorButton.backgroundColor = [UIColor brownColor];
                    break;
                case 7:
                    colorButton.backgroundColor = [UIColor purpleColor];
                    break;
                case 8:
                    colorButton.backgroundColor = [UIColor grayColor];
                    break;
                case 9:
                    colorButton.backgroundColor = [UIColor whiteColor];
                    break;
            }

        }
    }
    
    
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

@end
