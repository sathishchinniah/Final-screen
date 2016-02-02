//
//  ViewController.h
//  wall2
//
//  Created by Sathish Chinniah on 28/12/15.
//  Copyright © 2015 Sathish Chinniah. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CircleView.h"

@interface ViewController : UIViewController
- (CGSize)sizeThatFits:(CGSize)size ;

@property(weak,nonatomic) IBOutlet UIView *viewGreen;

@property(weak,nonatomic) IBOutlet UIView *viewBlue;

@property(weak,nonatomic) IBOutlet UILabel *lblLeftDays;

@property(weak,nonatomic) IBOutlet UILabel *lblCost1,*lblCost2;

@property(weak,nonatomic) IBOutlet UILabel *lblSubCost1,*lblSubCost2;

@property(weak,nonatomic) IBOutlet CircleView *arrowViewGreen;

@property(weak,nonatomic) IBOutlet CircleView *arrowViewBlue;

@property(weak,nonatomic) IBOutlet NSLayoutConstraint *widthConstraint;

@property(weak,nonatomic) IBOutlet NSLayoutConstraint *heightConstraint;

@property(weak,nonatomic) IBOutlet NSLayoutConstraint *ImgYConstraint1;

@property(weak,nonatomic) IBOutlet NSLayoutConstraint *ImgYConstraint2;


//@property (weak, nonatomic) IBOutlet UILabel *flabel;
//@property (weak, nonatomic) IBOutlet UILabel *slabel;
//
//@property (weak, nonatomic) IBOutlet UILabel *tlabel;
//
//@property (weak, nonatomic) IBOutlet UILabel *folabel;
//
//@property (weak, nonatomic) IBOutlet UILabel *fivlabel;
//@property (weak, nonatomic) IBOutlet UILabel *sixlabel;
//@property (weak, nonatomic) IBOutlet UILabel *sevenlabel;
//
//
////@property (weak, nonatomic) IBOutlet UIView *walletView;//1
//
//@property (weak, nonatomic) IBOutlet UILabel *dateLabel;//2
//@property (weak, nonatomic) IBOutlet UIButton *leftBtn;
//@property (weak, nonatomic) IBOutlet UIButton *rightBtn;
//
//
//@property (weak, nonatomic) IBOutlet UILabel *NumberLabel;

@property(weak,nonatomic) IBOutlet UILabel *lblUsage;

@property (weak, nonatomic) IBOutlet UILabel *flabel;
@property (weak, nonatomic) IBOutlet UILabel *slabel;

@property (weak, nonatomic) IBOutlet UILabel *tlabel;

@property (weak, nonatomic) IBOutlet UILabel *folabel;

@property (weak, nonatomic) IBOutlet UILabel *fivlabel;
@property (weak, nonatomic) IBOutlet UILabel *sixlabel;
@property (weak, nonatomic) IBOutlet UILabel *sevenlabel;


//@property (weak, nonatomic) IBOutlet UIView *walletView;//1

@property (weak, nonatomic) IBOutlet UILabel *dateLabel;//2
@property (weak, nonatomic) IBOutlet UIButton *leftBtn;
@property (weak, nonatomic) IBOutlet UIButton *rightBtn;
@property(weak,nonatomic) IBOutlet UIView *chartview;
@property(nonatomic,strong)  UIScrollView *Customscrollview;

@property (weak, nonatomic) IBOutlet UITableView *tableView;



@end

