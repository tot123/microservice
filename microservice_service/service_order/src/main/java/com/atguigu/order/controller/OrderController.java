package com.atguigu.order.controller;

import com.atguigu.bean.OrderInfo;
import com.atguigu.order.service.OrderService;
import java.util.List;
import java.util.concurrent.ConcurrentHashMap;
import java.util.concurrent.atomic.AtomicInteger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

/*====================================================
                时间: 2022-06-21
                讲师: 刘  辉
                出品: 尚硅谷讲师团队
======================================================*/
@RestController
@RequestMapping("/order")
public class OrderController {

    public  static ConcurrentHashMap<String,  AtomicInteger> map = new ConcurrentHashMap();

    @Autowired
    private OrderService orderService;

    @GetMapping("/info/{id}")
    public List<OrderInfo> getOrderList(@PathVariable("id") Integer id){
        return orderService.getUserInfo(id);
    }
}
