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
