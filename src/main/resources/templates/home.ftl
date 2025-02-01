<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Chat</title>
    <script src="https://cdn.jsdelivr.net/npm/marked/marked.min.js"></script>
    <style>
        body, html {
            height: 100%;
            margin: 0;
            padding: 0;
            overflow: hidden; /* 防止出现滚动条 */
        }
        #chatContainer {
            display: flex;
            flex-direction: column;
            height: 100vh; /* 视口高度 */
            width: 100vw; /* 视口宽度 */
        }
        #chatbox {
            flex: 1; /* 占据剩余空间 */
            overflow-y: auto; /* 允许垂直滚动 */
            padding: 10px;
            border: none; /* 移除边框 */
            background-color: #f5f5f5; /* 背景颜色 */
        }
        .message {
            max-width: 60%;
            padding: 10px;
            margin: 5px;
            border-radius: 5px;
            white-space: pre-wrap; /* 保留换行符 */
            word-wrap: break-word; /* 允许长单词或URL地址换行到下一行 */
        }
        .my-message {
            align-self: flex-end;
            background-color: #07c160;
            color: white;
        }
        .other-message {
            align-self: flex-start;
            background-color: #e5e5ea;
        }
        #messageInputContainer {
            display: flex;
            padding: 10px;
            border-top: 1px solid #ccc; /* 顶部边框 */
        }
        #messageInput {
            flex: 1; /* 输入框占据剩余空间 */
            padding: 10px;
            border: 1px solid #ccc;
            border-radius: 5px;
            outline: none; /* 移除焦点轮廓 */
        }
        #sendButton {
            padding: 10px 20px;
            border: none;
            background-color: #07c160;
            color: white;
            border-radius: 5px;
            margin-left: 5px;
            cursor: pointer;
        }
        #loading {
            display: none; /* 默认隐藏 */
            margin-left: 5px;
            color: #07c160;
        }
        .message-container {
            display: flex;
            align-items: flex-end;
            margin-bottom: 5px;
        }
    </style>
</head>
<body>
<div id="chatContainer">
    <div id="chatbox">
        <!-- 聊天消息将显示在这里 -->
<#--        <span id="loading">加载中...</span> <!-- loading元素 &ndash;&gt;-->
    </div>
    <div id="messageInputContainer">
        <input type="text" id="messageInput" placeholder="输入消息...">
        <button id="sendButton" onclick="sendMessage()">发送</button>

    </div>
</div>
<script>
    function sendMessage() {
        var message = document.getElementById('messageInput').value;
        var chatbox = document.getElementById('chatbox');

        // 创建消息容器
        var messageContainer = document.createElement('div');
        messageContainer.className = 'message-container';

        // 创建并添加自己的消息元素
        var myMessageElement = document.createElement('div');
        myMessageElement.textContent = message;
        myMessageElement.className = 'message my-message';
        messageContainer.appendChild(myMessageElement);

        // 清空输入框
        document.getElementById('messageInput').value = '';

        // 创建并添加loading元素
        var loadingElement = document.createElement('span');
        loadingElement.textContent = '加载中...';
        loadingElement.className = 'loading';
        messageContainer.appendChild(loadingElement);

        // 添加消息容器到聊天框
        chatbox.appendChild(messageContainer);

        // 发送消息到服务器
        fetch('/chat', {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json'
            },
            body: JSON.stringify({ message: message })
        })
            .then(response => response.json())
            .then(data => {
                // 隐藏loading
                loadingElement.style.display = 'none';
                // 创建并添加服务器返回的消息元素
                // var responseMessageElement = document.createElement('div');
                // responseMessageElement.textContent = data.message;
                // responseMessageElement.className = 'message other-message';
                // chatbox.appendChild(responseMessageElement);
                // 显示服务器返回的消息在左边，并解析Markdown
                addMessage(data.message, 'other-message');

            })
            .catch(error => {
                // 隐藏loading并处理错误
                loadingElement.style.display = 'none';
                console.error('Error:', error);
            });
    }

    function addMessage(message, type) {
        var chatbox = document.getElementById('chatbox');
        var messageElement = document.createElement('div');
        // 使用marked.js解析Markdown
        messageElement.innerHTML = marked.parse(message);
        messageElement.className = 'message ' + type;
        chatbox.appendChild(messageElement);
        // 滚动到最新消息
        chatbox.scrollTop = chatbox.scrollHeight;
    }
</script>
</body>
</html>
