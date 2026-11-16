# Software Testing Portfolio — CHEN Zhanhong

Final-year Computer Science student at Guangzhou College of Commerce, graduating June 2027.
This repository collects my testing practice into one end-to-end workflow: **test points → test cases → execution → defect logging → test summary**.

> The case sheets, defect records and test summary are written in Chinese. The structure and the numbers are summarised below so the material can be reviewed without reading Chinese.

## Contents

| Folder | Contents ||
|---|---|---|
| `01-Web UI功能测试/` | Login and pop-up modules: 16 test cases, 16 execution screenshots, 3 defect records, 1 test summary | Complete |
| `02-接口测试/` | Postman collection with 16 requests, Fiddler captures, 12 screenshots | Complete |
| `03-SQL练习/` | 6 queries: JOIN, GROUP BY, HAVING, subquery, monthly aggregation, LIMIT / OFFSET | Complete |
| `04-缺陷报告/` | Defect report template and 3 defect records for the login module | 3 of 5 planned |
| `05-Linux笔记/` | Common commands, ports and processes | Notes only |
| `06-Python脚本/` | Status-code statistics script: pass / fail counts and pass rate, with empty-input handling | Complete |

## 1. Web UI functional testing

- **Target:** the login and pop-up modules of a public web practice site.
- **16 test cases** (7 login, 9 pop-up), designed with equivalence partitioning, boundary value analysis, decision tables and scenario-based design.
- **Result:** 13 passed, 3 failed.
- **3 defects**, all the same class of issue: an empty username, an empty password, or both empty return a generic *"invalid username or password"* message instead of a field-level required-field message. Severity S3, priority P1.
- Every case has an execution screenshot (16 in total), and each defect record contains reproduction steps, test environment, expected vs actual result and attachments.

## 2. API testing

- **Postman collection:** 16 requests against the public [DummyJSON](https://dummyjson.com) API — authentication, users, products, carts and negative cases.
- **Token chaining:** the `accessToken` returned by the login request is stored in a collection variable and injected as `Authorization: Bearer {{token}}` in later requests.
- **Assertions:** status code, field presence and field type.
- **Batch execution:** Collection Runner.
- **Isolation check:** key requests were re-run with cookies cleared, confirming that the Bearer token — not a session cookie — authorises access.
- **Negative case:** a wrong password returns 400 with an error message.
- **Fiddler:** captured a local Flask practice site's login flow. Successful login returns 302 with `地址` and `Set-Cookie`; failed login returns 200 with the login page and no cookie. This separates form-session login from token-based API authentication.

## 3. SQL, Linux and Python

- **SQL:** 6 queries covering JOIN, GROUP BY / HAVING, subqueries, monthly aggregation and LIMIT / OFFSET.
- **Linux:** notes on common commands, file permissions, ports and processes.
- **Python:** `stats.py`, a small script that counts passed / failed status codes and calculates a pass rate, including empty-input handling. The scope of this script is intentionally small.

## How to review

- **Postman** — import `02-接口测试/接口测试实践-DummyJSON.postman_collection.json`, then run *login* followed by *get current user with token*.
- **SQL** — paste the schema from `03-SQL练习/sql练习.sql` into [sqliteonline.com](https://sqliteonline.com) and run the queries.
- **Python** — `python 06-Python脚本/stats.py`

## Scope

All artefacts in this repository were produced by me as self-directed practice between September and November 2026. No client or company data is included. Systems under test are either a public practice site or a public demo API — they are not products I built.

## Contact

CHEN Zhanhong · 17727331381@163.com · [github.com/chenzhanhong1](https://github.com/chenzhanhong1)
