//
//  ViewController.m
//  cameraDemo
//
//  Created by joe feng on 2015/12/16.
//  Copyright © 2015年 joe feng. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () {
    UIImageView *imgView;
}

-(void) takePicture:(UIButton *) sender;            // 按下[拍照]按鈕

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // camera btn
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(10, 50, [UIScreen mainScreen].bounds.size.width - 20, 50)];
    btn.backgroundColor = [UIColor blueColor];
    [btn setTitle:@"拍照" forState:UIControlStateNormal];
    btn.layer.cornerRadius = 5;
    btn.clipsToBounds = YES;
    [btn addTarget:self action:@selector(takePicture:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    
    // image
    imgView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 300, [UIScreen mainScreen].bounds.size.width - 20, 200)];
    imgView.hidden = NO;
    [self.view addSubview:imgView];
    
}

// 按下[拍照]按鈕
-(void) takePicture:(UIButton *) sender {
    AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
    if(authStatus == AVAuthorizationStatusAuthorized || authStatus == AVAuthorizationStatusNotDetermined) {
        //建立一個ImagePickerController
        UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
        
        // 設定影像來源 這裡設定為相機
        imagePicker.sourceType =  UIImagePickerControllerSourceTypeCamera;
        
        // 設置 delegate
        imagePicker.delegate = self;
        
        // 設置拍照完後 可以編輯 會多一個編輯照片的步驟
        imagePicker.allowsEditing = YES;
        
        // 顯示相機功能
        [self presentViewController:imagePicker animated:YES completion:nil];
    } else {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"無法存取相機" message:@"請至 設定>隱私權 中開啟權限" preferredStyle:UIAlertControllerStyleAlert];
        
        // 確定按鈕
        [alert addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        }]];
        
        [self presentViewController:alert animated:YES completion:nil];
    }
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    
    // 取得編輯後的圖片 UIImage
    UIImage *img = [info objectForKey:UIImagePickerControllerEditedImage];
    if (img == nil) {
        // 如果沒有編輯 則是取得原始拍照的照片 UIImage
        img = [info objectForKey:UIImagePickerControllerOriginalImage];
    }
    
    // 再來就是對圖片的處理 img 是一個 UIImage
    imgView.image = img;
    
    //移除Picker
    [picker dismissViewControllerAnimated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
