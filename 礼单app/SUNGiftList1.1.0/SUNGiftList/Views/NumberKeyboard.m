//
//  NumberKeyboard.m
//  SUNGiftList
//
//  Created by 孙 化育 on 13-4-22.
//  Copyright (c) 2013年 孙 化育. All rights reserved.
//

#import "NumberKeyboard.h"

@implementation NumberKeyboard
@synthesize textField = _textField;

- (void)dealloc {
    [_buttonArray release];
    [super dealloc];
}

- (id)init{
    self = [super init];
    if (self) {
        NSArray *aNib = [[NSBundle mainBundle]loadNibNamed:NSStringFromClass([self class]) owner:self options:nil];
        UIView *view = [aNib objectAtIndex:0];
        self.frame = view.bounds;
        [self addSubview:view];
        for (UIButton *button in _buttonArray) {
            [button setBackgroundImage:[[UIImage imageNamed:@"rBTN.png"] stretchableImageWithLeftCapWidth:35
                                                                                              topCapHeight:35]
                               forState:UIControlStateNormal];
            [button setBackgroundImage:[[UIImage imageNamed:@"rBTN_CLICK.png"] stretchableImageWithLeftCapWidth:35
                                                                                                    topCapHeight:35]
                               forState:UIControlStateHighlighted];
        }
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (id<UITextInput>)delegate {
    return _textField;
}

- (UITextField *)textField {
    return _textField;
}

- (void)setTextField:(UITextField *)textField {
    _textField = textField;
    _textField.inputView = self;
}

- (BOOL)enableInputClicksWhenVisible {
    return YES;
}

- (IBAction)singleNumberClick:(UIButton *)sender{
    [[UIDevice currentDevice] playInputClick];
    [self.delegate insertText:sender.currentTitle];
}
- (IBAction)quickButtonClick:(UIButton *)sender{
    [[UIDevice currentDevice] playInputClick];
    _textField.text = sender.currentTitle;
}
- (IBAction)defaultButtonClick:(UIButton *)sender{
    [[UIDevice currentDevice] playInputClick];
    [_textField.delegate textFieldShouldReturn:_textField];
}
- (IBAction)backClick:(UIButton *)sender{
    [[UIDevice currentDevice] playInputClick];
    [self.delegate deleteBackward];
}
- (IBAction)cleanButtonClick:(UIButton *)sender{
    [[UIDevice currentDevice] playInputClick];
    _textField.text = @"";
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/


@end
