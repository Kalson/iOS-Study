//
//  LPAVC.m
//  Login Page
//
//  Created by KaL on 8/12/14.
//  Copyright (c) 2014 Kalson Kalu. All rights reserved.
//

#import "LoginVC.h"
#import "LPAVC.h"

@interface LoginVC ()<UITextFieldDelegate>

@end

@implementation LoginVC
{
    UITextField *userTextField;
    UITextField * user;
    UITextField * pass;
    UITextField * email;
    UITextField * phone;
    
    LPAVC *vC;
}

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
    
    vC = [[LPAVC alloc]init];
    
    int rowCount = 4;
    int rowButtons = 2;
    int colCount = 5;
    int button = 2;
    
    for (int row = 0; row < rowCount; row++)
    {
        int spacing = 10;
    
        int y = (spacing + 40) * row;

        userTextField = [[UITextField alloc]initWithFrame:CGRectMake(20, 20 + y, SCREEN_WIDTH - 40, 40)];
        userTextField.backgroundColor = [UIColor whiteColor];
        userTextField.layer.cornerRadius = 5;
        userTextField.delegate = self;
        [self.view addSubview:userTextField];
        
        UIView *paddingView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 10, 20)];
        userTextField.leftView = paddingView;
        userTextField.leftViewMode = UITextFieldViewModeAlways;
        
        switch (row) {
            case 0:
                user = userTextField;
                user.placeholder = @"Username";
                break;
            case 1:
                pass = userTextField;
                pass.placeholder = @"Password";
                pass.secureTextEntry = YES;
                break;
            case 2:
                email = userTextField;
                email.placeholder = @"Email";
                email.keyboardType = UIKeyboardTypeEmailAddress;
                break;
            default:
                phone = userTextField;
                phone.placeholder = @"Phone Number";
                phone.keyboardType = UIKeyboardTypePhonePad;
                break;
        }
    }
    
    
    for (int row = 0; row < button; row++)
    {
        int spacing = 10;
        int y = (spacing + 40) * row;
        
        UIButton *buttons = [[UIButton alloc]initWithFrame:CGRectMake(20, (SCREEN_HEIGHT - 100) + y, SCREEN_WIDTH - 40, 40)];
        buttons.backgroundColor = [UIColor whiteColor];
        [buttons setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        buttons.layer.cornerRadius = 5;
        [self.view addSubview:buttons];
        
        switch (row) {
            case 0:
                [buttons setTitle:@"Login" forState:UIControlStateNormal];
                buttons.backgroundColor = [UIColor redColor];
                [buttons addTarget:self action:@selector(loginButton) forControlEvents:UIControlEventTouchUpInside];
                break;
                
            default:
                [buttons setTitle:@"Reset" forState:UIControlStateNormal];
                buttons.backgroundColor = [UIColor orangeColor];
                [buttons addTarget:self action:@selector(resetButton) forControlEvents:UIControlEventTouchUpInside];
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
            [colorButton addTarget:self action:@selector(changeColor:) forControlEvents:UIControlEventTouchUpInside];
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
                    colorButton.backgroundColor = [UIColor lightGrayColor];
                    break;
                case 9:
                    colorButton.backgroundColor = [UIColor darkGrayColor];
                    break;
            }

        }
    }
    
    
}

- (void)changeColor:(UIButton *)button
{
    self.view.backgroundColor = button.backgroundColor;
    vC.view.backgroundColor = button.backgroundColor;
}

- (void)loginButton
{
    if ([userTextField.text isEqual:@""])
    {
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Login Failed" message:@"Try again" delegate:self cancelButtonTitle:@"ok" otherButtonTitles:nil];
        [alert show];
    } else {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Login Was Successful" message:nil delegate:self cancelButtonTitle:@"Ok" otherButtonTitles: nil];
        [alert show];
        
        [self presentViewController:vC animated:YES completion:nil];
    }
   
}

- (void)resetButton
{
    self.view.backgroundColor = [UIColor cyanColor];
    
    user.text = @"";
    pass.text = @"";
    email.text = @"";
    phone.text = @"";
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

@end
