def stats(codes):
    """统计数据码列表中的 PASS/FAIL 数量和通过率。"""
    if not codes:
        return 0, 0, 0
    pass_count = 0
    fail_count = 0
    for status in codes:
        if status == 200:
            pass_count += 1
        else:
            fail_count += 1
    rate = pass_count / len(codes)
    return pass_count, fail_count, rate


if __name__ == "__main__":
    print(stats([200, 404, 500, 200, 200]))  # (3, 2, 0.6)
    print(stats([]))                          # (0, 0, 0)
    print(stats([200, 200]))                  # (2, 0, 1.0)
