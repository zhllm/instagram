//
//  Date+Extensions.swift
//  instagram
//
//  Created by 张杰 on 2020/12/21.
//

import Foundation

/// 日期格式化器 - 不要频繁的释放和创建，会影响性能
private let dateFormatter = DateFormatter()
/// 当前日历对象
private let calendar = Calendar.current

extension Date {
    /// 计算与当前系统时间偏差 delta 秒数的日期字符串
    /// 结构体 static 修饰 -> 静态函数 == 类方法 class func
    static func zl_dateString(delta: TimeInterval) -> String {
        let date = Date(timeIntervalSinceNow: delta)
        dateFormatter.dateFormat = "YYYY-MM-DD HH:mm:ss"
        return dateFormatter.string(from: date)
    }
    
    
    /// 相对时间计算
    //   --  刚刚(一分钟内)
    //   --  X分钟前(一小时内)
    //   --  X小时前(当天)
    //   --  昨天 HH:mm(昨天)
    //   --  MM-dd HH:mm(一年内)
    //   --  yyyy-MM-dd HH:mm(更早期)
    var zl_dateDescription: String {
        if calendar.isDateInToday(self) {
            let dealt = -Int(self.timeIntervalSinceNow)
            if dealt < 60 {
                return "刚刚"
            }
            if dealt < 3600 {
                return "\(dealt / 60) 分钟前"
            }
            
            return "\(dealt / 3600) 小时前"
        }
        // 其他天
        var fmt = " HH:mm"
        
        if calendar.isDateInYesterday(self) {
            fmt = "昨天" + fmt
        } else {
            fmt = "MM-DD" + fmt
            let year = calendar.component(.year, from: self)
            let thisYear = calendar.component(.year, from: Date())
            
            if year != thisYear {
                fmt = "YYYY-" + fmt
            }
        }
        dateFormatter.dateFormat = fmt
        return dateFormatter.string(from: self)
    }
}
