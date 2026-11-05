# Linux 常用命令

> 目标：能在测试环境里看日志、查进程、查端口、传文件。不要求会运维。

## 怎么练（Windows）

三选一：

1. **WSL2 + Ubuntu（推荐）**：管理员打开 PowerShell，执行 `wsl --install`，重启后按提示设置用户名密码。
2. **Git Bash**：你装 Git 时自带，能练 `cd/ls/grep/tail` 等大部分命令。
3. **在线 Linux**：没装 WSL 时，用网页版沙箱先熟悉命令。

## 15 个命令

| # | 命令 | 作用 | 例子 | 测试场景 |
|---|---|---|---|---|
| 1 | `pwd` | 显示当前目录 | `pwd` | 确认自己在哪 |
| 2 | `ls -l` / `ls -a` | 列文件（含隐藏文件） | `ls -la` | 找日志、配置文件 |
| 3 | `cd` | 切换目录 | `cd /var/log` | 进日志目录 |
| 4 | `cat` | 看小文件全部内容 | `cat app.log` | 看短日志/配置 |
| 5 | `less` | 分页看大文件 | `less app.log` | 大日志翻页，`/关键词` 搜索，`q` 退出 |
| 6 | `tail -f` | 实时看文件末尾 | `tail -f app.log` | 边操作边看日志 |
| 7 | `head` | 看前 N 行 | `head -n 20 app.log` | 看日志开头/启动信息 |
| 8 | `grep` | 搜关键字 | `grep -n "ERROR" app.log` | 找报错行号 |
| 9 | `find` | 按名字找文件 | `find . -name "*.log"` | 找日志文件 |
| 10 | `ps aux \| grep` | 查进程 | `ps aux \| grep python` | 看服务起没起 |
| 11 | `top` | 看 CPU/内存 | `top` | 看哪个进程占资源，`q` 退出 |
| 12 | `ss -tulnp` / `netstat -tulnp` | 查端口占用 | `ss -tulnp \| grep 8000` | 服务端口通不通 |
| 13 | `curl` | 发 HTTP 请求 | `curl -i http://localhost:8000` | 接口通不通、看响应头 |
| 14 | `chmod` | 改权限 | `chmod +x run.sh` | 脚本没权限时 |
| 15 | `tar` | 压缩/解压 | `tar -zxvf app.tar.gz` | 解压部署包 |

加分项（面试常问）：

| 命令 | 作用 | 例子 |
|---|---|---|
| `ssh` | 远程登录 | `ssh user@192.168.1.10` |
| `scp` | 远程传文件 | `scp app.log user@host:/tmp/` |
| `df -h` / `du -sh` | 磁盘空间 | `df -h`、`du -sh *` |

## 一个练习场景（30 分钟）

```bash
# 1. 起一个本地服务
python3 -m http.server 8000

# 2. 另开一个终端，实时看日志（如果没有日志文件，先重定向）
python3 -m http.server 8000 > server.log 2>&1 &
tail -f server.log

# 3. 发请求
curl -i http://localhost:8000
curl -i http://localhost:8000/not-exist

# 4. 搜 404
grep -n "404" server.log

# 5. 查端口
ss -tulnp | grep 8000

# 6. 查进程并结束
ps aux | grep http.server
kill <PID>
```

**要截图的三处**：`tail -f` 实时日志、`grep 404` 结果、`ss -tulnp` 端口。

## 面试怎么说

> “测试环境排查问题时，我一般先 `tail -f` 看实时日志，用 `grep` 搜 ERROR 或请求 ID；再 `ss -tulnp` 确认服务端口；需要发请求就用 `curl`；改配置/传包用 `scp`。”

## 产出

- 一页 `linux-notes.md`：命令 + 作用 + 你实际执行的截图；
- 放 GitHub，简历技能栏加一行“熟悉 Linux 常用命令，能看日志、查端口、定位基础环境问题”。
