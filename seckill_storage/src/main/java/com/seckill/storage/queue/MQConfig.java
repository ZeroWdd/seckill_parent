package com.seckill.storage.queue;

import org.springframework.amqp.core.Queue;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;


/**
 * @Auther: wdd
 * @Date: 2019/9/11 15:22
 * @Description:
 */
@Configuration
public class MQConfig {
    @Bean
    public Queue queueStorage(){
        return new Queue("storage_queue",true);
    }
}
