# Algo-Swift

![Swift](https://img.shields.io/badge/Swift-%23FF4088.svg?&style=for-the-badge&logo=swift&logoColor=white)

This repo is about algorithm codes writing by Swift. Two parts included.

## 🗝 Solutions

My solutions of [LeetCode](https://leetcode.com/problemset/all/) problems with **Swift**.

### ⏳ Progress

| Difficulty | Progress |
| :----- | :----- |
| Easy   | 102/610 |
| Medium | 80/1327 |
| Hard   | 3/552  |

> Motivation comes from incentive.

- 🔸 ~~Lv.1 "100 easy"~~ 🎯🎉
- 🔹 Lv.10 "200 easy" 🚶🚶🚶
- 🔶 Lv.20 [🥉] "500 easy"
- 🔷 Lv.30 "AK easy"
- 🟢 ~~Lv.40 "100 medium"~~ 🎯🎉
- 🟠 Lv.50 [🥈] "200 medium" 🚶🚶🚶
- 🔵 Lv.60 "400 medium
- 🟣 Lv.70 "600 medium"
- 🟩 Lv.80 "100 hard"
- 🟧 Lv.90 [🥇] "200 hard"
- 🟦 Lv.100 "300 hard"
- 🟪 Lv.110 "AK medium"
- 🔱 Lv.120 [🏆] "AK hard"

## 📦 Base

### 📔 Templetes

While solving problems I summarize those code snippets as templates. Thanks to references:

* [raywenderlich/swift-algorithm-club](https://github.com/raywenderlich/swift-algorithm-club)

* [SunZhiC/DataStructuresInSwift](https://github.com/SunZhiC/DataStructuresInSwift)

* LeetCode Solution Pages, such as https://leetcode.com/problems/merge-k-sorted-lists/solution/

#### ‼️ VSCode-LeetCode extension

To fix `redeclaration of 'Solution' issue`, I modified the extension.

* path: `~/.vscode/extensions/leetcode.vscode-leetcode-0.18.1`


1. add `Custom Flags` to `Build Settings` of Xcode project

![](https://ryder-1252249141.cos.ap-shanghai.myqcloud.com/uPic/2022-11-13-EycSUM.png)

2. change template

* `/node_modules/vsc-leetcode-cli/templates/codeonly.tpl`

```swift
// codeonly.tpl
${comment.start}
${comment.line} @lc app=${app} id=${fid} lang=${lang}
${comment.line}
${comment.line} [${fid}] ${name}
${comment.end}

${comment.singleLine} @lc code=start
#if !LC_SOLUTION_EXT
class Solution {}
#endif
${code}
${comment.singleLine} @lc code=end
```

3. change js logic

* `node_modules/vsc-leetcode-cli/lib/core.js`

```
core.exportProblem = function(problem, opts) {
  const data = _.extend({}, problem);
  // ... 
  data.code = (opts.code || data.code || '').replace(/\r\n/g, '\n');
  data.comment = h.langToCommentStyle(data.lang);
  data.percent = data.percent.toFixed(2);
  data.testcase = util.inspect(data.testcase || '');

  // fix 'swift' redeclaration issue
  data.code = data.code.replace(/class Solution/g, 'extension Solution');

  // ...
  return file.render(opts.tpl, data);
};
```

### 📚 Books

![](https://ryder-1252249141.cos.ap-shanghai.myqcloud.com/uPic/2022-11-15-ZoByQo.png)

I bought several books about algorithm years ago, mostly writen by Liu Rujia (as known as [@srbga](https://www.topcoder.com/members/srbga)).

> Of course never finished reading them :(

Now I'm going to rewrite codes in these books with Swift.

Let's Go! 🖖
