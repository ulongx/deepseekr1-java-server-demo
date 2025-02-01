package cn.dvptech.aids.service.impl;

import cn.dvptech.aids.service.ChatService;
import org.springframework.ai.ollama.OllamaChatModel;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

/**
 * @author ulongx
 */
@Service
public class ChatServiceImpl implements ChatService {

    @Autowired
    private OllamaChatModel ollamaChatModel;

    @Override
    public String processMessage(String message) {
        // 使用ai发送消息

        return ollamaChatModel.call(message);
    }
}