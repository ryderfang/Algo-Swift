/*
 * @lc app=leetcode id=355 lang=swift
 *
 * [355] Design Twitter
 */

// @lc code=start
#if !LC_SOLUTION_EXT
class Solution {}
#endif

class Twitter {
    var userTweets: [[_Tweet]]
    var userFollow: [Set<Int>]
    var autoIncId = 0
    struct _Tweet {
        var tweetId: Int
        var orderId: Int
    }

    init() {
        userTweets = [[_Tweet]](repeating: [_Tweet](), count: 501)
        userFollow = [Set<Int>](repeating: Set<Int>(), count: 501)
    }
    
    func postTweet(_ userId: Int, _ tweetId: Int) {
        let t = _Tweet(tweetId: tweetId, orderId: autoIncId)
        autoIncId += 1
        userTweets[userId].append(t)
    }
    
    func getNewsFeed(_ userId: Int) -> [Int] {
        var ans = [_Tweet]()
        let selfTweets = userTweets[userId]
        ans.append(contentsOf: selfTweets)
        let fo = userFollow[userId]
        for u in fo {
            ans.append(contentsOf: userTweets[u])
        }
        return Array(ans.sorted(by: { $0.orderId > $1.orderId })
            .map { $0.tweetId }
            .prefix(10))
    }
    
    func follow(_ followerId: Int, _ followeeId: Int) {
        var fo = userFollow[followerId]
        fo.insert(followeeId)
        userFollow[followerId] = fo
    }
    
    func unfollow(_ followerId: Int, _ followeeId: Int) {
        var fo = userFollow[followerId]
        fo.remove(followeeId)
        userFollow[followerId] = fo
    }
}

/**
 * Your Twitter object will be instantiated and called as such:
 * let obj = Twitter()
 * obj.postTweet(userId, tweetId)
 * let ret_2: [Int] = obj.getNewsFeed(userId)
 * obj.follow(followerId, followeeId)
 * obj.unfollow(followerId, followeeId)
 */
// @lc code=end

