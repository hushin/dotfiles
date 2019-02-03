#!/bin/bash -eu

# 前日に書いた日報ファイルをコピー

# * 日報ファイルをコピーして今日の日付でファイルを生成します
#   * すでに今日のファイルがある場合はコピーしません
# * コピーしたファイルのパスを出力します

memoDir="$HOME/Documents/memo/_posts"
dailyReportSuffix="-daily-report.md"
weekTexts=(日 月 火 水 木 金 土)
week=${weekTexts[`date +%w`]}
todayText=`date "+# %Y/%m/%d ($week)"`

cd $memoDir
newestDailyReport=`ls -t *$dailyReportSuffix | head -1`
todayDailyReport=`date +%Y-%m-%d$dailyReportSuffix`

function echoDailyReportPath () {
  echo $memoDir/$todayDailyReport
}

if [ $newestDailyReport = $todayDailyReport ]; then
  echoDailyReportPath
  exit 0
fi

cp $newestDailyReport $todayDailyReport
# * 一行目を今日の日付で上書き
sed -i '' -e "1s|^.*$|$todayText|" $todayDailyReport
# * Markdownの完了タスクを消す
sed -i '' -e "/^ *[-+*] \[[xX]\].*/d" $todayDailyReport

echoDailyReportPath
exit 0
