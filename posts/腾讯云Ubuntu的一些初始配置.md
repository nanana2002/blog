#### 连接
##### 1. 去cloudflare设置dns
##### 2. 打开ssh密码root登录（个人反感密钥登陆）
``` shell
sudo vim /etc/ssh/sshd_config

```

> PermitRootLogin yes

> save

```shell
sudo passwd root
sudo  systemctl  restart  ssh
```
##### 3. 关闭监控程序
```shell
wget -qO- https://raw.githubusercontent.com/littleplus/TencentAgentRemove/master/remove.sh | bash
rm -rf /usr/local/qcloud
bash /usr/local/qcloud/YunJing/uninst.sh
bash /usr/local/qcloud/stargate/admin/uninstall.sh
bash /usr/local/qcloud/monitor/barad/admin/uninstall.sh
systemctl stop tat_agent
systemctl disable tat_agent
rm -f /etc/systemd/system/tat_agent.service
crontab -e #自行删除
```
