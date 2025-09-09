# .github/workflows/feishu_digest_card.jq

# 定义一个函数，用于生成单个来源的新闻模块
def section(title; content):
  if ($content | length > 0) then
    [
      {"tag": "hr"},
      {"tag": "div", "text": {"tag": "lark_md", "content": "**" + title + "**"}},
      {"tag": "div", "text": {"tag": "lark_md", "content": $content}}
    ]
  else
    []
  end;

{
  "msg_type": "interactive",
  "card": {
    "config": { "wide_screen_mode": true },
    "header": {
      "title": { "tag": "plain_text", "content": "📰 每日热榜简报" },
      "template": "blue"
    },
    "elements": [
      {"tag": "div", "text": {"tag": "lark_md", "content": ("**更新时间:** " + $ENV.UPDATE_TIME)}}
    ] +
    section("36氪 | 热榜"; $ENV.KR_NEWS) +
    section("掘金 | 热榜"; $ENV.JUEJIN_NEWS) +
    section("GitHub | Trending"; $ENV.GITHUB_NEWS) +
    [
      {"tag": "hr"},
      {
        "tag": "action",
        "actions": [
          {
            "tag": "button",
            "text": { "tag": "plain_text", "content": "前往 36氪" },
            "type": "default",
            "url": "https://36kr.com/"
          },
          {
            "tag": "button",
            "text": { "tag": "plain_text", "content": "前往 掘金" },
            "type": "default",
            "url": "https://juejin.cn/hot"
          },
          {
            "tag": "button",
            "text": { "tag": "plain_text", "content": "前往 GitHub" },
            "type": "default",
            "url": "https://github.com/trending"
          }
        ]
      }
    ]
  }
}
