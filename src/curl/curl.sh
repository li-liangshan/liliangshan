#!/usr/bin/env bash

# curl命令是一个利用URL规则在命令行下工作的文件传输工具。它支持文件的上传和下载，所以是综合传输工具，但按传统，习惯称curl为下载工具。
# 作为一款强力工具，curl支持包括HTTP、HTTPS、ftp等众多协议，还支持POST、cookies、认证、从指定偏移处下载部分文件、用户代理字符串、
# 限速、文件大小、进度条等特征。做网页处理流程和数据检索自动化，curl可以祝一臂之力。

curl www.sina.com

# 如果要把这个网页保存下来，可以使用`-o`参数，这就相当于使用wget命令了。
curl -o [文件名] www.sina.com

# 有的网址是自动跳转的。使用`-L`参数，curl就会跳转到新的网址。
curl -L www.sina.com

# `-i`参数可以显示http response的头信息，连同网页代码一起。
curl -i www.sina.com
# `-I`参数则是只显示http response的头信息。
curl -I www.baidu.com

# `-v`参数可以显示一次http通信的整个过程，包括端口连接和http request头信息。
curl -v www.baidu.com

# 发送表单信息有GET和POST两种方法。GET方法相对简单，只要把数据附在网址后面就行。
curl example.com/form.cgi?data=xxx
# POST方法必须把数据和网址分开，curl就要用到--data参数。
curl -X POST --data "data=xxx" example.com/form.cgi
# 如果你的数据没有经过表单编码，还可以让curl为你编码，参数是`--data-urlencode`。
curl -X POST--data-urlencode "date=April 1" example.com/form.cgi

# curl默认的HTTP动词是GET，使用`-X`参数可以支持其他动词。
curl -X POST www.example.com
curl -X DELETE www.example.com

# 文件上传
# 假定文件上传的表单是下面这样：
#
#　　<form method="POST" enctype='multipart/form-data' action="upload.cgi">
#　　　　<input type=file name=upload>
#　　　　<input type=submit name=press value="OK">
#　　</form>

curl --form upload=@localfilename --form press=OK [URL]

# 有时你需要在http request头信息中，提供一个referer字段，表示你是从哪里跳转过来的。
curl --referer http://www.example.com http://www.example.com

# User Agent字段: 这个字段是用来表示客户端的设备信息。服务器有时会根据这个字段，针对不同设备，返回不同格式的网页，比如手机版和桌面版。
curl --user-agent "[User Agent]" [URL]

# 使用`--cookie`参数，可以让curl发送cookie。
# 至于具体的cookie的值，可以从http response头信息的`Set-Cookie`字段中得到。
# `-c cookie-file`可以保存服务器返回的cookie到文件，`-b cookie-file`可以使用这个文件作为cookie信息，进行后续的请求。
curl --cookie "name=xxx" www.example.com

# 有时需要在http request之中，自行增加一个头信息。`--header`参数就可以起到这个作用。
curl --header "Content-Type:application/json" http://example.com

# 有些网域需要HTTP认证，这时curl需要用到`--user`参数。
curl --user name:password example.com


