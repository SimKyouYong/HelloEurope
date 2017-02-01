//
//  GlobalHeader.h
//  HelloEurope
//
//  Created by Joseph_iMac on 2016. 3. 23..
//  Copyright © 2016년 Joseph_iMac. All rights reserved.
//

#define WIDTH_FRAME             [[UIScreen mainScreen] bounds].size.width
#define HEIGHT_FRAME            [[UIScreen mainScreen] bounds].size.height

// NSUserDefaults
#define DEVICE_TOKEN            @"device_token"
#define DEVICE_UUID             @"device_uuid"
#define REMEMBER_IDPW_SAVE      @"remember_save"

#define KEY_INDEX               @"key_index"
#define KEY_NAME                @"key_name"
#define KEY_USER_ID             @"key_user_id"
#define KEY_USER_PW             @"key_user_pw"
#define KEY_USER_EMAIL          @"key_user_email"
#define KEY_USER_PHONE          @"key_user_phone"
#define KEY_USER_BIRTH          @"key_user_birth"
#define KEY_CHOO                @"key_choo"
#define KEY_MY_EA               @"key_my_ea"
#define KEY_LEVEL               @"key_level"
#define KEY_IMAGE               @"key_image"

#define SETTING_PUSH            @"setting_push"
#define SETTING_ALARMEVENT      @"setting_alarmevent"
#define SETTING_MSG             @"setting_msg"
#define SETTING_COMMENT         @"setting_comment"
#define SETTING_LIKE            @"setting_like"

#define TODAY_CHECK             @"today_check"

// URL
#define COMMON_URL              @"http://coaineu.cafe24.com/Hellow/php/"
#define LOGIN_URL               @"Login.php"
#define PW_SEARCH_URL           @"PW_Find.php"
#define MEMBERJOIN_URL          @"Join.php"
#define TALKLIST_URL            @"HellowTalkSel.php"
#define TALKDEL_URL             @"HellowTalk_Del.php"
#define TALKCOMENT_URL          @"HellowTalkComment_Sel.php"
#define TALKCOMENT_DEL_URL      @"HellowTalk_Comment_Del.php"
#define TALKWRITE_URL           @"HellowTalk_Write.php"
#define TALKWRITE_EDIT_URL      @"HellowTalk_Write_Update.php"
#define TALKCOMENT_WRITE_URL    @"HellowTalk_Comment_Write.php"
#define TALKLIKE_URL            @"HellowTalkGood.php"
#define TALKIMAGE_URL           @"Image_Submit.php"
#define TALKREFRESH_URL         @"HellowTalkComment_Reflash.php"
#define TALKSEARCH_URL          @"HellowTalk_Search.php"
#define EUROPASS_LIST_URL       @"EuropePath_Sel.php"
#define MP3_URL                 @"http://coaineu.cafe24.com/Hellow/mp3/"
#define EUROPEFOOD_COUPON_URL   @"EuropeFood_Sel.php"
#define CART_URL                @"HellowTalk_Basket.php"
#define MY_PROFILE_URL          @"My_Image_Submit.php"
#define MY_PROFILE_URL2         @"My_img_Set.php"
#define MY_POST_URL             @"Mypage_Post_Sel.php"
#define MY_COMENT_URL           @"Mypage_Comment_Sel.php"
#define MY_BOOKMARK_URL         @"Mypage_Bookmark_Sel.php"
#define MY_CART_URL             @"Mypage_Basket_Sel.php"
#define MY_PAYLIST_URL          @"Mypage_Pay_Sel.php"
#define MY_POINT_URL            @"Mypage2_Point_Sel.php"
#define MY_BOOKMARK_URL         @"Mypage_Bookmark_Sel.php"
#define INAPP_POINT_URL         @"Point_pay.php"
#define PAY_URL                 @"Point_path_set.php"
#define AD_POPUP_URL            @"Ad_Sel.php"
#define DANGER_URL              @"Danger.php"
#define AUDIO_POINT_URL         @"Point_set.php"

// 메모리 보관
#define POINT_CHECK             [GlobalObject sharedInstance].pointCheck
#define LOGIN_CHECK             [GlobalObject sharedInstance].loginCheck
#define BACK_NUMBER             [GlobalObject sharedInstance].backNumber
#define EDIT_KEYINDEX           [GlobalObject sharedInstance].editKeyIndex
#define SORT_TOP_NUMBER         [GlobalObject sharedInstance].sortTopNumber
#define BOTTOM_AD_CHECK         [GlobalObject sharedInstance].bottomAdCheck

#define DOCUMENT_DIRECTORY [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject]
#define PHOTO_FOLDER            @"photo"

// Country Title Image
#define ITALIA_IMAGE            @"italia_talk_title"
#define FRANCE_IMAGE            @"france_talk_title"
#define AUSTRIA_IMAGE           @"austria_talk_title"
#define SPAIN_IMAGE             @"spagna_talk_title"
#define GERMANY_IMAGE           @"germany_talk_title"
#define SWISS_IMAGE             @"swizland_talk_title"
#define ENGIL_IMAGE             @"engil_talk_title"
#define CHECKO_IMAGE            @"check_talk_title"
#define CROATIA_IMAGE           @"ungheria_talk_title"
#define OTHER_IMAGE             @"other_talk_title"







