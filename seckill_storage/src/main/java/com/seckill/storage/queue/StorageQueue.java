package com.seckill.storage.queue;

import com.seckill.storage.service.StorageService;
import org.springframework.amqp.rabbit.annotation.RabbitListener;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import java.util.HashMap;
import java.util.Map;

/**
 * @Auther: wdd
 * @Date: 2019/9/11 15:13
 * @Description:
 */
@Component
public class StorageQueue {
    @Autowired
    private StorageService storageService;

    @RabbitListener(queues = "storage_queue")
    public void getStorageQueue(String msg){
        System.out.println("storage_queue接收消息："+msg);

        Map<String, Object> result = new HashMap<String, Object>();
        try {
            result = storageService.insertStorage(msg, 0, 1);

            if (!(Boolean) result.get("result")){
                System.out.println("storage_queue消息处理失败："+result.get("msg"));
            }
        }catch (Exception e){
            System.out.println("storage_queue消息处理失败："+e.getMessage());
        }

        System.out.println("storage_queue消息处理完毕！"+result);
    }
}
