# 接口测试实践（Postman + Fiddler）

## 项目是什么

对 DummyJSON 公开 API 做接口测试，覆盖登录鉴权、商品、用户、购物车和异常场景，共 16 个请求；并用 Fiddler 抓包分析本地 Flask 网站的登录流程。

## 目录

| 文件/目录 | 内容 |
|---|---|
| `接口测试实践-DummyJSON.postman_collection.json` | Postman 集合，16 个请求 |
| `截图/01-登录200.png` | 登录成功，200 + 3/3 |
| `截图/02-token变量.png` | 集合变量里 `token` 有值 |
| `截图/03-authme200.png` | 带 Bearer token 调 `/auth/me`，200 + 2/2 |
| `截图/04-密码错误400.png` | 负向用例，400 + 2/2 |
| `截图/05-清Cookie.png` | 清掉 Cookie，做隔离验证 |
| `截图/06-抓包-成功登录-302.png` | Fiddler：成功登录 302 + Location + Set-Cookie |
| `截图/07-抓包-失败登录-200.png` | Fiddler：失败登录 200，无 Location |
| `截图/08-抓包-WebForms.png` | Fiddler：请求体里的 username/password |
| `截图/09-抓包-登录失败页面.png` | 浏览器：提示“用户名或密码错误” |
| `截图/10-抓包-请求列表.png` | Fiddler：登录流程的请求列表 |
| `截图/11-抓包-失败响应体-TextView.png` | Fiddler：响应体 HTML 里的“用户名或密码错误” |
| `截图/12-抓包-失败响应-WebView.png` | Fiddler：渲染后的失败登录页 |

## 我做了什么

1. 登录接口获取 `accessToken`，用脚本存进集合变量 `token`；
2. 后续请求在 Header 带 `Authorization: Bearer {{token}}`，验证鉴权；
3. 编写状态码、字段存在性、字段类型断言；
4. 用 Collection Runner 跑多组数据；
5. 清 Cookie 后再跑 `/auth/me`，确认是 Bearer 生效，不是 Cookie 假通过；
6. 负向用例：密码错误，断言 400 + `message`；
7. 用 Fiddler 抓本地 Flask 登录：`POST /login/sumbit`，成功返回 302 + `Location: /user-center` + `Set-Cookie: session=...`；
8. 对比失败登录：返回 200 + 登录页 HTML，提示“用户名或密码错误”，没有 Location 和 Cookie。

## 结果

- 登录：200 + 3/3；
- `/auth/me`：200 + 2/2；
- 密码错误：400 + 2/2；
- 清 Cookie 后仍 200，排除 Cookie 假通过；
- 抓包对比：成功 302/跳转/种 Cookie，失败 200/留在登录页/不种 Cookie。

## 面试怎么讲

> 登录接口返回 200 和 accessToken，我用脚本把它存进集合变量；下一个请求在 Header 带 `Bearer {{token}}`，返回 200。为了确认不是 Cookie 生效，我清掉 Cookie 再跑，还是 200；负向用例密码错误，断言 400 和错误信息，2/2 通过。
>
> 另外我用 Fiddler 抓了本地 Flask 的登录：成功是 302 + Location + Set-Cookie，失败是 200 + 登录页 + “用户名或密码错误”，没有 Location 和 Cookie。这样能分清“表单登录”和“接口鉴权”的差异。

## 怎么复现

**Postman：**

1. Import 集合 JSON；
2. 先跑「1-认证 / 登录-正确」，再跑「获取当前用户-带Token」；
3. 负向用例跑「登录-密码错误」。

**Fiddler：**

1. 打开 Fiddler，确认 `Capturing`；
2. 浏览器访问 `http://10.23.34.137:5000`（不要用 127.0.0.1，浏览器会绕过代理）；
3. 登录一次成功、一次失败；
4. 点 `POST /login/sumbit`，看 Headers / WebForms / Response。
