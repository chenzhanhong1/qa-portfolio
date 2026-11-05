-- 1. 2026年订单总额最高的前3个用户
SELECT u.name ,sum(o.amount) AS total_amount
FROM users as u
LEFT JOIN orders as o
on u.id = o.user_id
WHERE o.created_at >= '2026-01-01' AND o.created_at < '2027-01-01'
GROUP by u.id ,u.name
ORDER by sum(o.amount) DESC
LIMIT 3;
-- 2. 每个用户的下单数量
SELECT u.name ,count(o.id) as id_count
FROM users as u
LEFT JOIN orders as o
on u.id = o.user_id
GROUP by u.id ,u.name；

-- 3. 订单总额超过200的用户
SELECT u.name ,sum(o.amount) as total_amount
FROM users as u
LEFT JOIN orders as o
on u.id = o.user_id
GROUP by u.id ,u.name
HAVING sum(o.amount) > 200;

-- 4. 没有下过单的用户
SELECT u.name
FROM users u
LEFT JOIN orders o ON o.user_id = u.id
WHERE o.id IS NULL;

ps：
我错在了忘记count（）是不会返回null空值的，只会返回0
用反连接更稳
要找“没有关联记录”的行，用 LEFT JOIN ... WHERE 右表.id IS NULL。 （高频点）

-- 5. 2026年每月订单总额
SELECT substr(o.created_at, 1, 7) AS month, sum(o.amount) as total_amount
FROM orders o
WHERE  o.created_at >= '2026-01-01' AND o.created_at < '2027-01-01' 
GROUP BY month
ORDER by month ASC;

ps：
我忘记了substr的用法是：substr(字符串, 起始位置, 长度)，位置从 1 开始，长度可省略。
可以用来做同月

-- 6. 订单总额排第2的用户
SELECT u.name , sum(o.amount) as total_amount
FROM users u
LEFT JOIN orders o ON o.user_id = u.id
GROUP BY u.id ,u.name
ORDER BY total_amount DESC
LIMIT 1 OFFSET 1;

--还有一种子查询的方法
SELECT u.name, SUM(o.amount) AS total_amount
FROM users u
JOIN orders o ON o.user_id = u.id
GROUP BY u.id, u.name
HAVING SUM(o.amount) < (
    SELECT MAX(total)
    FROM (
        SELECT SUM(amount) AS total
        FROM orders
        GROUP BY user_id
    ) t
)
ORDER BY total_amount DESC
LIMIT 1;

ps：我忘记了聚合不能套聚合，要做成子查询
offset 1 是跳过第一条
