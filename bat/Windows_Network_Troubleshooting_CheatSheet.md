
# 🛠 Windows 网络排障命令速查合集

---

## 📡 1. `ipconfig` - 查看和管理 IP 配置

```cmd
ipconfig                 :: 查看基本IP配置
ipconfig /all            :: 查看详细配置（MAC、DNS、租约时间）
ipconfig /release        :: 释放当前 IP（DHCP 模式）
ipconfig /renew          :: 重新申请 IP 地址
ipconfig /flushdns       :: 清除 DNS 缓存
ipconfig /displaydns     :: 显示 DNS 缓存
```

---

## 📶 2. `ping` - 测试网络连通性和延迟

```cmd
ping 8.8.8.8             :: 测试公网连通
ping www.baidu.com       :: 测试域名解析和连通
ping -n 5 192.168.1.1    :: 连续 ping 5 次
ping -t 192.168.1.1      :: 持续 ping（Ctrl+C 停止）
```

---

## 🌐 3. `tracert` - 路由追踪（逐跳）

```cmd
tracert www.google.com   :: 查看数据包路由路径
tracert /d www.baidu.com :: 不解析域名，加快速度
```

---

## 🔍 4. `nslookup` - 域名解析诊断

```cmd
nslookup                 :: 进入交互模式
nslookup www.baidu.com   :: 查询域名的 IP
nslookup 8.8.8.8         :: 查询 IP 对应的域名
nslookup -type=mx qq.com :: 查询邮件服务器记录
```

---

## 📊 5. `netstat` - 查看网络连接状态

```cmd
netstat -a               :: 所有连接和监听端口
netstat -n               :: 不解析域名（显示IP）
netstat -an | find "80"  :: 查找80端口使用情况
netstat -b               :: 查看使用端口的程序（需管理员）
```

---

## 🛣 6. `route` - 查看/修改路由表

```cmd
route print              :: 显示当前路由表
route add 0.0.0.0 mask 0.0.0.0 192.168.1.1 :: 添加默认路由
route delete 0.0.0.0     :: 删除默认路由
```

---

## 🧰 7. 其他实用工具

| 工具/命令                 | 功能                         |
|--------------------------|------------------------------|
| `tasklist`               | 查看所有进程                 |
| `taskkill /PID 1234 /F`  | 强制结束指定进程             |
| `arp -a`                 | 查看本地 ARP 缓存            |
| `netsh interface ipv4 show config` | 查看网络接口详细配置 |
| `netsh winsock reset`    | 重置网络组件（解决异常连接） |
| `net use`                | 查看网络驱动器共享           |
| `telnet IP port`         | 测试端口是否通（需启用 Telnet） |

---

## 🚨 使用技巧

- **建议使用管理员 CMD 执行命令**
- **分页查看长输出**：加 `| more`，如：
  ```cmd
  netstat -an | more
  ```

---

> 📘 *By ChatGPT | 适合日常网络故障排查、自学参考、应急使用*

