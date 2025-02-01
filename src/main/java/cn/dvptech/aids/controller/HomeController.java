package cn.dvptech.aids.controller;

import cn.dvptech.aids.service.ChatService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.Collections;
import java.util.Map;

@Controller
public class HomeController {
    @Autowired
    private ChatService chatService;

    @GetMapping("/")
    public String home(Model model) {
        model.addAttribute("message", "Hello, FreeMarker!");
        // 这将渲染src/main/resources/templates/home.ftl
        return "home";
    }

    @PostMapping("/chat")
    @ResponseBody
    public Map<String, String> sendChatMessage(@RequestBody Map<String, String> request) {
        String message = request.get("message");
        // 使用Service处理消息
        String responseMessage = chatService.processMessage(message);
        // 返回处理后的消息
        return Collections.singletonMap("message", responseMessage);
    }
}
