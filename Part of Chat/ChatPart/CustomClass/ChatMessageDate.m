//
//  ChatMessageDate.m
//  聊天时间显示
//
//  Created by macmini2 on 16/9/23.
//  Copyright © 2016年 emiage. All rights reserved.
//

#import "ChatMessageDate.h"

@implementation ChatMessageDate
+(NSString*)chatMessageTimeStr:(long long)timestamp{
    // 创建日历对象
    NSCalendar * calendar = [NSCalendar currentCalendar];
    // 获取当前时间
    NSDate *currentDate = [NSDate date];
    // 获取当前时间的年、月、日。利用日历
    NSDateComponents *components = [calendar components:NSCalendarUnitYear| NSCalendarUnitMonth|NSCalendarUnitDay |NSCalendarUnitWeekday fromDate:currentDate];
    NSInteger currentYear = components.year;
    NSInteger currentMonth = components.month;
    NSInteger currentDay = components.day;
    
    
    
    
    
    //接受到消息的时间搓
    NSDate * msgDate =[NSDate dateWithTimeIntervalSince1970:timestamp];
    components = [calendar components:NSCalendarUnitYear| NSCalendarUnitMonth|NSCalendarUnitDay|NSCalendarUnitHour|NSCalendarUnitWeekday fromDate:msgDate];
    NSInteger msgYear = components.year;
    NSInteger msgMonth = components.month;
    NSInteger msgDay = components.day;
    NSInteger msgWeek =components.weekday;
    
    
    
    // 进行判断
    NSDateFormatter *dateFmt = [[NSDateFormatter alloc] init];
    [dateFmt setDateStyle:NSDateFormatterFullStyle];
    if (currentYear == msgYear && currentMonth == msgMonth && currentDay == msgDay) {
        //今天
        dateFmt.dateFormat = @"HH:mm";
    }else if (currentYear == msgYear && currentMonth == msgMonth && currentDay-1 == msgDay ){
        //昨天
        dateFmt.dateFormat = @"昨天 HH:mm";
    }else{
        //昨天以前(一个星期内显示星期 否则显示日期)
        if ([[self class]isSameWeekBeforeDate:msgDate withCurrentDate:currentDate]) {
            dateFmt.dateFormat = [NSString stringWithFormat:@"%@ HH:mm",[self getWeekdayWithNumber:msgWeek]];
        }else{
            NSString * time ;
            if(components.hour>0 && components.hour <16){
                time=@"凌晨";
            }else if(components.hour>6 && components.hour <12){
                time=@"早上";
            }else if (components.hour== 12){
                time=@"中午";
            }else if (components.hour >12 && components.hour <18){
                time=@"下午";
            }else if (components.hour >18 && components.hour <24){
                time=@"晚上";
            }else{
                
            }
            
            if (msgYear !=currentYear) {
                dateFmt.dateFormat = [NSString stringWithFormat:@"YYYY年MM月dd日 %@HH:mm",time];
            }else{
                dateFmt.dateFormat = [NSString stringWithFormat:@"MM月dd日 %@HH:mm",time];
            }
            
        }
    }
    // 返回处理后的结果
    return [dateFmt stringFromDate:msgDate];
    
}




+(BOOL)isSameWeekBeforeDate:(NSDate *)beforeDate withCurrentDate:(NSDate *)currentDate{
    
    NSInteger num = [self compareDate:beforeDate Date:currentDate];
    // 先判断是否是同一天
    if (num == 0) {
        return YES;
    }
    NSInteger tempValue = [self getTimeSpaceDays:beforeDate :currentDate];
    // 判断时间间隔是否是小于7天
    if(tempValue>7){
        return NO;
    }else{
        NSDate* date = (num ==-1 ? beforeDate:currentDate);
        NSInteger weekday = [self weekdayStringFromDate:date];
        if(weekday+tempValue>7){
            return NO;
        }else{
            return YES;
        }
    }
    
    return NO;
}


+(NSInteger )weekdayStringFromDate:(NSDate*)inputDate {
    
    NSArray *weekdays = [NSArray arrayWithObjects: [NSNull null], @"7", @"1", @"2", @"3", @"4", @"5", @"6", nil];
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSTimeZone *timeZone = [[NSTimeZone alloc] initWithName:@"Asia/Shanghai"];
    [calendar setTimeZone: timeZone];
    NSCalendarUnit calendarUnit = NSCalendarUnitWeekday;
    NSDateComponents *theComponents = [calendar components:calendarUnit fromDate:inputDate];
    return [[weekdays objectAtIndex:theComponents.weekday] integerValue];;
}







// 判断差几天
+(NSInteger)getTimeSpaceDays:(NSDate *)beforeDate :(NSDate *)currentDate
{
    NSTimeInterval time=[currentDate timeIntervalSinceDate:beforeDate];
    NSInteger days=((int)time)/(3600*24);
    return days;
    
}




//字符串时间转换时间搓
+(NSDate*)stringTimeChangToDate:(NSString*)time{
    NSDateFormatter * formatter = [[NSDateFormatter alloc]init];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"];
    NSTimeZone *timeZone=[NSTimeZone systemTimeZone];
    [formatter setTimeZone:timeZone];
    NSDate * date = [formatter dateFromString:time];
    return date;
}


/*
 beforeDate 早于 NextDate 返回 -1
 
 beforeDate 等于 NextDate 返回 0
 
 beforeDate 晚于 NextDate 返回 1
 判断是否是同一天
 */

+(NSInteger)compareDate:(NSDate*)beforeDate Date:(NSDate *)NextDate
{
    NSTimeInterval time=[beforeDate timeIntervalSinceDate:NextDate];
    
    //  int hours=((int)time)%(3600*24)/3600
    NSInteger temp=0;
    if (time > 0)
    {
        temp= 1;
        // return temp;
    }else if(time==0)
    {
        temp= 0;
        //return temp;
    }else if(time < 0)
    {
        temp= -1;
        //return temp;
    }
    return temp;
    
}



//1代表星期日、如此类推
+(NSString *)getWeekdayWithNumber:(NSInteger)number
{
    
    switch (number) {
        case 1:
            return @"星期日";
            break;
        case 2:
            return @"星期一";
            break;
        case 3:
            return @"星期二";
            break;
        case 4:
            return @"星期三";
            break;
        case 5:
            return @"星期四";
            break;
        case 6:
            return @"星期五";
            break;
        case 7:
            return @"星期六";
            break;
        default:
            return @"";
            break;
    }
}








/**
 *  计算2个日期相差天数
 *  startDate   起始日期
 *  endDate     截至日期
 */
+(NSInteger)daysFromDate:(NSDate *)startDate toDate:(NSDate *)endDate {
    NSDateFormatter *dateFormatter=[[NSDateFormatter alloc] init];
    // 话说在真机上需要设置区域，才能正确获取本地日期，天朝代码:zh_CN
    dateFormatter.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    //得到相差秒数
    NSTimeInterval time = [endDate timeIntervalSinceDate:startDate];
    int days = ((int)time)/(3600*24);
    int hours = ((int)time)%(3600*24)/3600;
    int minute = ((int)time)%(3600*24)/3600/60;
    if (days <= 0 && hours <= 0&&minute<= 0) {
        NSLog(@"0天0小时0分钟");
        return 0;
    }
    else {
        NSLog(@"%@",[[NSString alloc] initWithFormat:@"%i天%i小时%i分钟",days,hours,minute]);
        // 之所以要 + 1，是因为 此处的days 计算的结果 不包含当天 和 最后一天\
        （如星期一 和 星期四，计算机 算的结果就是2天（星期二和星期三），日常算，星期一——星期四相差3天，所以需要+1）\
        对于时分 没有进行计算 可以忽略不计
        return days +1 ;
    }
}


//把当前时间转换成UTC时间
+(NSDate *)JiaozhengDate:(NSDate *)date
{
    NSDateFormatter *formatter=[[NSDateFormatter alloc]init];
    formatter.dateFormat=@"yy-MM-dd HH:mm:ss";
    NSTimeZone *timeZone=[NSTimeZone systemTimeZone];
    NSInteger seconds=[timeZone secondsFromGMTForDate:date];
    NSDate *newDate=[date dateByAddingTimeInterval:seconds];
    return newDate;
}
@end
