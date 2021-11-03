// ---- Settings ----
Hints.characters = 'hlasdfgyuiowertnm'
settings.scrollStepSize = 140
settings.hintAlign = 'left'
// settings.aceKeybindings = 'emacs'
settings.nextLinkRegex = /((forward|>>|next|次[のへ]|→)+)/i
settings.prevLinkRegex = /((back|<<|prev(ious)?|前[のへ]|←)+)/i
// settings.historyMUOrder = false
settings.theme = `
#sk_status, #sk_find {
  font-size: 12pt;
}
#sk_omnibarSearchResult .highlight {
  background: #f9ec89;
}
`

// ---- Utils ----
const unmapKeys = (keys) => keys.forEach((key) => unmap(key))
const iunmapKeys = (keys) => keys.forEach((key) => iunmap(key))
const escapeMap = {
  '&': '&amp;',
  '<': '&lt;',
  '>': '&gt;',
  '"': '&quot;',
  "'": '&#39;',
  '/': '&#x2F;',
  '`': '&#x60;',
  '=': '&#x3D;',
}
const escapeForAlias = (str) =>
  String(str).replace(/[&<>"'`=/]/g, (s) => escapeMap[s])
const createSuggestionItem = (html, props = {}) => {
  const li = document.createElement('li')
  li.innerHTML = html
  return { html: li.outerHTML, props }
}
const padZero = (txt) => `0${txt}`.slice(-2)
const formatDate = (date, format = 'YYYY/MM/DD hh:mm:ss') =>
  format
    .replace('YYYY', date.getFullYear())
    .replace('MM', padZero(date.getMonth() + 1))
    .replace('DD', padZero(date.getDate()))
    .replace('hh', padZero(date.getHours()))
    .replace('mm', padZero(date.getMinutes()))
    .replace('ss', padZero(date.getSeconds()))

const tabOpenBackground = (url) =>
  RUNTIME('openLink', {
    tab: {
      tabbed: true,
      active: false,
    },
    url,
  })

// ---- Maps ----
map('>_r', 'r')
map('>_E', 'E')
map('>_R', 'R')
map('>_S', 'S')
map('S', 'sg') // 選択したテキストまたはクリップボードからググる
map('r', 'gf') // 別タブで開く
map('H', '>_S') // back in history
map('L', 'D') // forward in history
map('h', 'E') // previousTab
map('l', '>_R') // nextTab
map('R', '>_r') // reload

map('<Ctrl-[>', '<Esc>')

iunmap(':') // disable emoji
// disable vim binding in insert mode
iunmapKeys([
  '<Ctrl-a>',
  '<Ctrl-e>',
  '<Ctrl-f>',
  '<Ctrl-b>',
  '<Ctrl-k>',
  '<Ctrl-y>',
])
// disable proxy
unmapKeys(['cp', ';pa', ';pb', ';pc', ';pd', ';ps', ';ap'])

// ---- Search ----
removeSearchAliasX('b')
removeSearchAliasX('w')

// hatena tag
addSearchAlias('th', 'hatena tag', 'http://b.hatena.ne.jp/search/tag?q=')

// Twitter
addSearchAlias(
  'tw',
  'Twitter',
  'https://twitter.com/search?q=',
  's',
  'https://twitter.com/i/search/typeahead.json?count=10&filters=true&q=',
  (response) =>
    JSON.parse(response.text).topics.map((v) =>
      createSuggestionItem(v.topic, {
        url: `https://twitter.com/search?q=${encodeURIComponent(v.topic)}`,
      })
    )
)
mapkey('otw', '#8Open Search with alias tw', function () {
  Front.openOmnibar({ type: 'SearchEngine', extra: 'tw' })
})

addSearchAlias(
  'tf',
  'Twitter フォロワーのみ',
  'https://twitter.com/search?pf=on&q='
)

// Google jp 3ヶ月以内
addSearchAlias(
  '3',
  'Google 3ヶ月以内',
  'https://www.google.co.jp/search?q={0}&tbs=qdr:m3,lr:lang_1ja&lr=lang_ja'
)

// Yahoo!リアルタイム検索
addSearchAliasX(
  'r',
  'Yahoo!リアルタイム検索',
  'http://realtime.search.yahoo.co.jp/search?ei=UTF-8&p='
)
mapkey('or', '#8Open Search with alias r', function () {
  Front.openOmnibar({ type: 'SearchEngine', extra: 'r' })
})

// Wikipedia jp
addSearchAlias(
  'wi',
  'Wikipedia',
  'https://ja.wikipedia.org/w/index.php?search='
)

// MDN
addSearchAliasX(
  'mdn',
  'MDN',
  'https://developer.mozilla.org/ja/search?q=',
  's',
  'https://developer.mozilla.org/api/v1/search/ja?q=',
  (response) => {
    const res = JSON.parse(response.text)
    return res.documents.map((s) =>
      createSuggestionItem(
        `
      <div>
        <div class="title"><strong>${s.title}</strong></div>
        <div style="font-size:0.8em"><em>${s.slug}</em></div>
        <div>${s.summary}</div>
      </div>
    `,
        { url: `https://developer.mozilla.org/${s.locale}/docs/${s.slug}` }
      )
    )
  }
)

// npm
addSearchAliasX(
  'npm',
  'npm',
  'https://www.npmjs.com/search?q=',
  's',
  'https://api.npms.io/v2/search/suggestions?size=20&q=',
  (response) =>
    JSON.parse(response.text).map((s) => {
      let flags = ''
      let desc = ''
      let stars = ''
      let score = ''
      if (s.package.description) {
        desc = escapeForAlias(s.package.description)
      }
      if (s.score && s.score.final) {
        score = Math.round(Number(s.score.final) * 5)
        stars = '⭐'.repeat(score) + '☆'.repeat(5 - score)
      }
      if (s.flags) {
        Object.keys(s.flags).forEach((f) => {
          flags += `[<span style='color:#ff4d00'>⚑</span> ${escapeForAlias(
            f
          )}] `
        })
      }
      return createSuggestionItem(
        `
      <div>
        <style>.title>em { font-weight: bold; }</style>
        <div class="title">${s.highlight}</div>
        <div>
          <span style="font-size:1.5em;line-height:1em">${stars}</span>
          <span>${flags}</span>
        </div>
        <div>${desc}</div>
      </div>
    `,
        { url: s.package.links.npm }
      )
    })
)

// Amazon jp
addSearchAliasX(
  'am',
  'Amazon',
  'https://www.amazon.co.jp/s?k=',
  's',
  'https://completion.amazon.co.jp/search/complete?method=completion&search-alias=aps&mkt=6&q=',
  (response) => JSON.parse(response.text)[1]
)

// Amazon jp Kindle
addSearchAliasX(
  'k',
  'Amazon Kindle',
  'https://www.amazon.co.jp/s?i=digital-text&k=',
  's',
  'https://completion.amazon.co.jp/search/complete?method=completion&search-alias=aps&mkt=6&q=',
  (response) => JSON.parse(response.text)[1]
)

// alc
addSearchAlias('a', 'alc', 'https://eow.alc.co.jp/search?q=')
mapkey('oa', '#8Open Search with alias a', function () {
  Front.openOmnibar({ type: 'SearchEngine', extra: 'a' })
})

// mercari
addSearchAlias('m', 'mercari', 'https://www.mercari.com/jp/search/?keyword=')

// ---- Mapkeys ----//
const copyTitleAndUrl = (format) => {
  const text = format
    .replace('%URL%', location.href)
    .replace('%TITLE%', document.title)
  Clipboard.write(text)
}
const copyHtmlLink = () => {
  const clipNode = document.createElement('a')
  const range = document.createRange()
  const sel = window.getSelection()
  clipNode.setAttribute('href', location.href)
  clipNode.innerText = document.title
  document.body.appendChild(clipNode)
  range.selectNode(clipNode)
  sel.removeAllRanges()
  sel.addRange(range)
  document.execCommand('copy', false, null)
  document.body.removeChild(clipNode)
  Front.showBanner('Ritch Copied: ' + document.title)
}

mapkey('cm', '#7Copy title and link to markdown', () => {
  copyTitleAndUrl('[%TITLE%](%URL%)')
})
mapkey('ct', '#7Copy title and link to textile', () => {
  copyTitleAndUrl('"%TITLE%":%URL%')
})
mapkey('ch', '#7Copy title and link to human readable', () => {
  copyTitleAndUrl('%TITLE% / %URL%')
})
mapkey('cb', '#7Copy title and link to scrapbox', () => {
  copyTitleAndUrl('[%TITLE% %URL%]')
})
mapkey('ca', '#7Copy title and link to href', () => {
  copyTitleAndUrl('<a href="%URL%">%TITLE%</a>')
})
mapkey('cp', '#7Copy title and link to plantuml', () => {
  copyTitleAndUrl('[[%URL% %TITLE%]]')
})
mapkey('cr', '#7Copy rich text link', () => {
  copyHtmlLink()
})
mapkey('co', '#7Copy title and link to org', () => {
  copyTitleAndUrl('[[%URL%][%TITLE%]]')
})
//  8: Omnibar
//  9: Visual Mode
// 10: vim-like marks
// 11: Settings
// 12: Chrome URLs
mapkey('gS', '#12Open Chrome settings', () => tabOpenLink('chrome://settings/'))
// 13: Proxy
// 14: Misc
mapkey(';a', '#14Save to Instapaper', () => {
  function iprl5() {
    var d = document,
      z = d.createElement('scr' + 'ipt'),
      b = d.body,
      l = d.location
    try {
      if (!b) throw 0
      d.title = '(Saving...) ' + d.title
      z.setAttribute(
        'src',
        l.protocol +
          '//www.instapaper.com/j/TbVSmwFP6fKy?a=read-later&u=' +
          encodeURIComponent(l.href) +
          '&t=' +
          new Date().getTime()
      )
      b.appendChild(z)
    } catch (e) {
      alert('Please wait until the page has loaded.')
    }
  }
  iprl5()
})

mapkey(';b', '#14hatena bookmark', () => {
  const { location } = window
  let url = location.href
  if (location.href.startsWith('https://app.getpocket.com/read/')) {
    url = decodeURIComponent(
      document
        .querySelector('header a')
        .getAttribute('href')
        .replace('https://getpocket.com/redirect?url=', '')
    )
  }
  if (url.startsWith('http:')) {
    tabOpenBackground(
      `http://b.hatena.ne.jp/entry/${url.replace('http://', '')}`
    )
    return
  }
  if (url.startsWith('https:')) {
    tabOpenBackground(
      `http://b.hatena.ne.jp/entry/s/${url.replace('https://', '')}`
    )
    return
  }
  throw new Error('はてなブックマークに対応していないページ')
})

mapkey(';G', '#14魚拓', () => {
  tabOpenLink(`https://megalodon.jp/?url=${location.href}`)
})

// org
const escapeChars = ['(', ')', "'"]
const escapeForOrg = (text) => {
  let _text = text
  escapeChars.forEach((char) => {
    _text = _text.replaceAll(char, escape(char))
  })
  return _text
}
const getUrl = (path, query) => {
  const queryString = Object.entries(query)
    .map(
      ([key, value]) =>
        `${encodeURIComponent(key)}=${escapeForOrg(encodeURIComponent(value))}`
    )
    .join('&')
  return [path, queryString].join('?')
}
const orgCapture = (template) => {
  const url = getUrl('org-protocol://capture', {
    template,
    url: window.location.href,
    title: document.title.replace(/\|/g, '-'),
    body: window.getSelection(),
  })
  console.log(`orgCapture: ${url}`)
  window.location.href = url
}
mapkey('ocm', '#14org-capture memo', () => {
  orgCapture('M')
})
mapkey('oct', '#14org-capture todo', () => {
  orgCapture('T')
})
mapkey('ocl', '#14org-capture read it later', () => {
  orgCapture('L')
})

mapkey('=q', '#14Delete query', () => {
  location.href = location.href.replace(/\?.*/, '')
})
mapkey('=h', '#14Delete hash', () => {
  location.href = location.href.replace(/\#.*/, '')
})
// 15: Insert Mode

// ---- qmarks ----
const qmarksMapKey = (prefix, urls, newTab) => {
  const openLink = (link, newTab) => () => {
    RUNTIME('openLink', {
      tab: { tabbed: newTab },
      url: link,
    })
  }
  for (const key in urls) {
    mapkey(prefix + key, `qmark: ${urls[key]}`, openLink(urls[key], newTab))
  }
}
const qmarksUrls = {
  m: 'https://mail.google.com/mail/u/0/',
  h: 'http://b.hatena.ne.jp/hush_in/hotentry',
  i: 'https://www.instapaper.com/u',
  tw: 'https://twitter.com/',
  td: 'https://tweetdeck.twitter.com/',
}
unmap('gn')
qmarksMapKey('gn', qmarksUrls, true)
qmarksMapKey('gO', qmarksUrls, false)

// --- Site-specific mappings ---
const clickElm = (selector) => () => document.querySelector(selector).click()
if (/speakerdeck.com/.test(window.location.hostname)) {
  const clickElmFr = (selector) => () =>
    document
      .querySelector('.speakerdeck-iframe')
      .contentWindow.document.querySelector(selector)
      .click()
  mapkey(']', 'next page', clickElmFr('.sd-player-next'))
  mapkey('[', 'prev page', clickElmFr('.sd-player-previous'))
}

if (/www.slideshare.net/.test(window.location.hostname)) {
  mapkey(']', 'next page', clickElm('#btnNext'))
  mapkey('[', 'prev page', clickElm('#btnPrevious'))
}

if (/booklog.jp/.test(window.location.hostname)) {
  mapkey(']', 'next page', clickElm('#modal-review-next'))
  mapkey('[', 'prev page', clickElm('#modal-review-prev'))
  mapkey('d', '読み終わった', clickElm('#status3'))
  mapkey('R', 'Read by Kindle', () =>
    RUNTIME('openLink', {
      tab: { tabbed: true },
      url: `https://read.amazon.co.jp/?asin=${document
        .querySelector('.item-area-info-title a')
        .getAttribute('href')
        .replace(/.*\//, '')}`,
    })
  )
}

if (/www.amazon.co.jp/.test(window.location.hostname)) {
  mapkey('=s', '#14URLを短縮', () => {
    location.href = `https://www.amazon.co.jp/dp/${
      document.querySelectorAll("[name='ASIN'], [name='ASIN.0']")[0].value
    }`
  })
}

if (
  /^https:\/\/b.hatena.ne.jp\/.*\/hotentry\?date/.test(window.location.href)
) {
  const moveDate = (diff) => () => {
    const url = new URL(window.location.href)
    const dateTxt = url.searchParams.get('date')
    const [_, yyyy, mm, dd] = dateTxt.match(/(....)(..)(..)/)
    const date = new Date(
      parseInt(yyyy, 10),
      parseInt(mm, 10) - 1,
      parseInt(dd, 10) + diff
    )
    url.searchParams.set('date', formatDate(date, 'YYYYMMDD'))
    location.href = url.href
  }
  mapkey(']]', 'next date', moveDate(1))
  mapkey('[[', 'prev date', moveDate(-1))
}

if (/youtube.com/.test(window.location.hostname)) {
  mapkey(
    'F',
    'Toggle fullscreen',
    clickElm('.ytp-fullscreen-button.ytp-button')
  )
  mapkey(
    'gH',
    'GoTo Home',
    () => (location.href = 'https://www.youtube.com/feed/subscriptions?flow=2')
  )
}

unmapAllExcept(
  [
    'E',
    'R',
    'd',
    'u',
    'T',
    'f',
    'F',
    'C',
    'x',
    'S',
    'H',
    'L',
    'cm',
    'co',
    'ch',
    'oct',
    'ocm',
  ],
  /mail.google.com|twitter.com|feedly.com|www.figma.com\/file/
)
if (/^https:\/\/www.amazon.co.jp\/gp\/video\//.test(window.location.href)) {
  // for Video Speed Controller
  unmapKeys(['d', 's', 'z', 'x', 'r', 'g'])
}

// click `Save` button to make above settings to take effect.

// refs.
// * https://github.com/b0o/surfingkeys-conf
// * https://github.com/ncaq/surfingkeys-ncaq
