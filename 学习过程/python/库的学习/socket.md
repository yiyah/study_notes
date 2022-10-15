# socket

[TOC]

## socket 简介

* Socket 是网络编程的一个抽象概念。通常我们用一个 Socket 表示“打开了一个网络链接”，而打开一个 Socket 需要知道目标计算机的 IP 地址和 端口号，再指定 协议类型 即可。

## 客户端

* 大多数连接都是可靠的TCP连接。创建TCP连接时，主动发起连接的叫客户端，被动响应连接的叫服务器。
* 客户端要主动发起TCP连接，必须知道服务器的IP地址和端口号。
* 下面是一个简单的 客户端 发起请求的程序

    ```python
    import socket
    import time

    Server_IP = "127.0.0.1"
    Server_PORT = 8080

    def Socket_connect():
        # 创建一个socket:
        # AF_INET：指定 IPv4 协议；AF_INET6： IPv6 协议。
        # SOCK_STREAM 指定使用面向流的 TCP 协议。
        s = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
        # 建立连接:
        s.connect((Server_IP, Server_PORT))  # 参数是一个 tuple
        return s


    if __name__ == '__main__':
        s = Socket_connect()
        while True:
            data = s.recv(1024)
            time.sleep(1)
            s.send(b"hzh")
            print(data.decode())
    ```

## 服务端

* 作为服务器，提供什么样的服务，端口号就必须固定下来。
* 服务器进程首先要绑定一个端口并监听来自其他客户端的连接。如果某个客户端连接过来了，服务器就与该客户端建立Socket连接，随后的通信就靠这个Socket连接了。
* 由于服务器会有大量来自客户端的连接，所以，服务器要能够区分一个Socket连接是和哪个客户端绑定的。**一个Socket依赖4项：服务器地址、服务器端口、客户端地址、客户端端口**来唯一确定一个Socket。
* 但是服务器还需要同时响应多个客户端的请求，所以，每个连接都需要一个新的进程或者新的线程来处理，否则，服务器一次就只能服务一个客户端了。

* 下面是一个简单的 服务端程序

    ```python
    import socket
    import threading
    import time

    Bind_IP = "127.0.0.1"   # 监听的地址
    Bind_PORT = 8080        # 监听的端口


    def Socket_Listen():
        s = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
        s.bind((Bind_IP, Bind_PORT))  # 绑定
        s.listen(1)                   # 开始监听，1是等待连接的最大数量
        print("Waiting for connection ...")
        return s


    def tcplink(sock, addr):
        print("Conneted!")
        sock.send(b"Welcom")  # 发送数据
        while True:
            # 接收数据，1024 一次最多接收指定的字节数
            data = sock.recv(1024).decode('utf-8')

            if not data or data == 'exit':
                break

            print(data)
            data = ('hello, %s!' % data).encode()
            sock.send(data)
        sock.close()
        print("close")


    if __name__ == '__main__':
        s = Socket_Listen()
        sock, addr = s.accept()  # accept() 会等待并返回一个客户端的连接:
        t = threading.Thread(target=tcplink, args=(sock, addr))
        t.start()
    ```

## 参考

1. [TCP编程](https://www.liaoxuefeng.com/wiki/1016959663602400/1017788916649408)
