# Linux 常用命令（测试环境）

目标：看日志、查进程、查端口、传文件，够用就行，不做运维。

## 练习环境

WSL2（Ubuntu 22.04）｜ 练习日期：2026.11

## 常用命令

| # | 命令 | 作用 | 例子 | 测试场景 |
|---|---|---|---|---|
| 1 | pwd | 显示当前目录 | `pwd` | 确认自己在哪 |
| 2 | ls -la | 列文件（含隐藏） | `ls -la` | 找日志、配置文件 |
| 3 | cd | 切换目录 | `cd /var/log` | 进日志目录 |
| 4 | cat | 看小文件 | `cat app.log` | 看短日志/配置 |
| 5 | less | 分页看大文件 | `less app.log` | 大日志翻页，`/关键词` 搜索，`q` 退出 |
| 6 | tail -f | 实时看文件末尾 | `tail -f app.log` | 边操作边看日志 |
| 7 | head | 看前 N 行 | `head -n 20 app.log` | 看启动信息 |
| 8 | grep | 搜关键字 | `grep -n "ERROR" app.log` | 找报错行号 |
| 9 | find | 按名字找文件 | `find . -name "*.log"` | 找日志文件 |
| 10 | ps aux \| grep | 查进程 | `ps aux \| grep python` | 看服务起没起 |
| 11 | top | 看 CPU/内存 | `top` | 看哪个进程占资源，`q` 退出 |
| 12 | ss -tulnp | 查端口占用 | `ss -tulnp \| grep 8000` | 服务端口通不通 |
| 13 | curl | 发 HTTP 请求 | `curl -i http://localhost:8000` | 接口通不通、看响应头 |
| 14 | chmod | 改权限 | `chmod +x run.sh` | 脚本没权限 |
| 15 | tar | 压缩/解压 | `tar -zxvf app.tar.gz` | 解压部署包 |

## 加分项（面试常问）

| 命令 | 作用 | 例子 |
|---|---|---|
| ssh | 远程登录 | `ssh user@192.168.1.10` |
| scp | 远程传文件 | `scp app.log user@host:/tmp/` |
| df -h / du -sh | 磁盘空间 | `df -h`、`du -sh *` |

## 一次练习（30 分钟）

1. `python3 -m http.server 8000` 起本地服务；
2. `tail -f server.log` 实时看日志；
3. `curl -i http://localhost:8000`、`curl -i http://localhost:8000/not-exist` 发请求；
4. `grep -n "404" server.log` 搜 404；
5. `ss -tulnp | grep 8000` 查端口；
6. `ps aux | grep http.server` + `kill <PID>` 收尾。

结果：留下 3 张截图，见下方。

## 截图

![tail -f 实时日志](screenshots/01-tail-f.png)

![grep 404](screenshots/02-grep-404.png)

![ss 端口查询](screenshots/03-ss-8000.png)

## 一句话总结

能用 tail/grep 看日志定位报错、用 ss/ps 查端口和进程、用 curl 快速验证接口通不通。
