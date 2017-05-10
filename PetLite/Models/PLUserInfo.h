//
//  PLUserInfo.h
//  PetLite
//
//  Created by sawyer3x on 17/5/10.
//  Copyright © 2017年 sawyer3x. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PLUserInfo : NSObject

@property (nonatomic, strong) NSString *avatarPic;  //头像
@property (nonatomic, strong) NSString *birthday;  //生日
@property (nonatomic, strong) NSString *city;  //城市
@property (nonatomic, strong) NSString *cityId;  //城市id
@property (nonatomic, strong) NSString *createTime;  //创建时间
@property (nonatomic, strong) NSString *dimensionsCode;  //二维码
@property (nonatomic, strong) NSString *idNum;  //身份证号
@property (nonatomic, strong) NSString *lat;  //纬度
@property (nonatomic, strong) NSString *lng;  //经度
@property (nonatomic, strong) NSString *pinyin;  //昵称拼音首字母
@property (nonatomic, strong) NSString *nickName;  //昵称
@property (nonatomic, strong) NSString *realName;  //真实姓名
@property (nonatomic, strong) NSString *phone;  //手机号
@property (nonatomic, strong) NSString *sex;  //性别 0,男 1,女
@property (nonatomic, strong) NSString *constellation;//星座
@property (nonatomic, strong) NSString *job;  //职业
@property (nonatomic, strong) NSString *affectiveState; //情感状态
@property (nonatomic, strong) NSString *interests;   //兴趣爱好
@property (nonatomic, strong) NSString *favoritePet; //喜爱的宠物(多个以英文逗号隔开)
@property (nonatomic, strong) NSString *petsTime; //养宠时间
@property (nonatomic, strong) NSString *sign;  //签名
@property (nonatomic, strong) NSString *status;  //用户状态  0正常 1禁用
@property (nonatomic, strong) NSString *userId;  //主键
@property (nonatomic, strong) NSString *password;  //密码（加密，MD5或者MD5+盐+酱油）
@property (nonatomic, strong) NSString *smallAvatarPic;// 小图
@property (nonatomic, strong) NSString *bigAvatarPic;// 大图
@property (nonatomic, strong) NSString *avatarBigImg;// 大图
@property (nonatomic, strong) NSString *petAge;//宠物年龄
@property (nonatomic, strong) NSString *petBreet;// 宠物种类
@property (nonatomic, strong) NSString *tarckPic;// 遛狗轨迹图片

@property (nonatomic, strong) NSString *invitationCode;//邀请码
@property (nonatomic, strong) NSString *hxId;//环信id

@property (nonatomic, strong) NSString *canCount;//罐头数

@property (nonatomic, strong) NSString *praiseCnt;//点赞数
@property (nonatomic, strong) NSString *activeTime;//活跃时间

@property (nonatomic, strong) NSArray <PetPetInfo> *petList;

@property (nonatomic, strong) NSArray * userAlbum;

@end

@interface NSDictionary (PLUserInfo)

- (PLUserInfo *) returnPLUserInfo;

@end
