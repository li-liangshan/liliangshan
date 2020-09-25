#!/bin/bash
function Prompt() {
  (whiptail --title "IP地址更改(yes/no)" --yesno "您是否需要重新配置IP地址？" 10 60)
  if [ $? -eq 0 ]; then
    ip_check()
  else
    whiptail --title "Nginx提示！" --msgbox "欢迎您再次使用Nginx一键安装服务." 10 60
    exit 1
  fi
}

function ip_check() {
  IP=$(whiptail --title "IP地址设置" --inputbox "请您输入您的IP地址" 10 60 3>&1 1>&2 2>&3)
  VALID_CHECK=$(echo $IP | awk -F. '$1<=255&&$2<=255&&$3<=255&&$4<=255{print "yes"}')
  if echo $IP | grep -E "^[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}$" >/dev/null; then
    if [[ "$VALID_CHECK" == "yes" ]]; then
      whiptail --title "IP地址合法提示！" --msgbox "您输入的IP地址正确，点击OK进行下一步配置！." 10 60
    fi
  else
    whiptail --title "IP地址错误提示！" --msgbox "您输入的IP地址可能有误,请您检查后再次输入！." 10 60
    Prompt
  fi
}

function install_nginx() {
  (whiptail --title "安装 Nginx？(yes/no)" --yesno "你是否需要安装Nginx？" 10 60)
  if [ $? -eq 0 ]; then
    {
      sleep 1
      echo 5
      apt-get update >/dev/null
      sleep 1
      echo 10
      sudo apt-get -y install build-essential >/dev/null &
      sleep 1
      echo 30
      sudo apt-get -y install openssl libssl-dev >/dev/null &
      sleep 1
      echo 50
      sudo apt-get -y install libpcre3 libpcre3-dev >/dev/null &
      sleep 1
      echo 70
      sudo apt-get -y install zlib1g-dev >/dev/null &
      sleep 1
      echo 90
      wget -q http://nginx.org/download/nginx-1.12.2.tar.gz >/dev/null
      sleep 1
      echo 95
      useradd -M -s /sbin/nologin nginx &
      tar zxf /root/nginx-1.12.2.tar.gz && cd /root/nginx-1.12.2/ &&
        ./configure --prefix=/usr/local/nginx  \
        --with-http_dav_module \
        --with-http_stub_status_module \
        --with-http_addition_module \
        --with-http_sub_module \
        --with-http_flv_module \
        --with-http_mp4_module \
        --with-pcre \
        --with-http_ssl_module \
        --with-http_gzip_static_module \
        --user=nginx >/dev/null && make >/dev/null && make install >/dev/null
      /usr/local/nginx/sbin/nginx &>/dev/null &
      sleep 100
    } | whiptail --gauge "正在安装Nginx,过程可能需要几分钟请稍后.........." 6 60 0 && whiptail --title "Nginx安装成功提示！！！" --msgbox "恭喜您Nginx安装成功，请您访问：http://$IP:80, 感谢使用~~~" 10 60
  else
    whiptail --title "Nginx提示！！！" --msgbox "感谢使用~~~" 10 60
    exit 1
  fi
}

function main() {
  ip_check
  install_nginx
}
main()
