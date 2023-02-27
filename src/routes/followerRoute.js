const express = require('express')
const router = express.Router()
const { auth, optionalAuth } = require('../middleware/userAuth')
const { PrismaClient } = require('@prisma/client')
const prisma = new PrismaClient()
const helper = require('../helper')

const use = fn => (req, res, next) =>
  Promise.resolve(fn(req, res, next)).catch(next)

router.post('/follow', auth, use(async (req, res) => {
  // #swagger.tags = ['Followers']

  await prisma.follower.create({
    data: {
      follower_id: req.body.followerID,
      followee_id: req.body.followeeID
    }
  })

  return helper.resSend(res, { status: 200 })
}
))

router.post('/unfollow', auth, async (req, res) => {
  // #swagger.tags = ['Followers']

  await prisma.follower.deleteMany({
    where: {
      follower_id: req.body.followerID,
      followee_id: req.body.followeeID
    }
  })

  return helper.resSend(res, { status: 200 })
})

router.get('/followersbyuserid/:id', optionalAuth, use(async (req, res) => {
  // #swagger.tags = ['Followers']

  let result = await prisma.follower.findMany({
    where: {
      followee_id: parseInt(req.params.id)
    },
    include: {
      user_follower_follower_idTouser: {
        select: {
          id: true,
          username: true,
          firstname: true,
          lastname: true,
          profileimage: true,
          color: true,
          bio: true
        }
      }
    }
  })

  const followersIds = []

  result.forEach(function (obj) {
    followersIds.push(obj.follower_id)
    obj.user = obj.user_follower_follower_idTouser
    delete obj.user_follower_follower_idTouser
    delete obj.followee_id
    delete obj.follower_id
  })

  result = await getNumberOfFollowers(result, followersIds)
  result = await getNumberOfIdeas(result, followersIds)
  result = await getNumberOfLikes(result, followersIds)

  if (req.user) {
    result = await getFollowingStatus(result, req.user.id, followersIds)
  }
  console.log(result)

  if (!result) {
    return helper.resSend(res, null, 'Error', 'Unknown error')
  } else {
    return helper.resSend(res, result)
  }
}))

router.get('/followeesbyuserid/:id', optionalAuth, use(async (req, res) => {
  // #swagger.tags = ['Followers']

  let result = await prisma.follower.findMany({
    where: {
      follower_id: parseInt(req.params.id)
    },
    include: {
      user_follower_followee_idTouser: {
        select: {
          id: true,
          username: true,
          firstname: true,
          lastname: true,
          profileimage: true,
          color: true,
          bio: true
        }
      }
    }
  })

  const followersIds = []

  result.forEach(function (obj) {
    followersIds.push(obj.followee_id)
    obj.user = obj.user_follower_followee_idTouser
    delete obj.user_follower_followee_idTouser
    delete obj.followee_id
    delete obj.follower_id
  })

  result = await getNumberOfFollowers(result, followersIds)
  result = await getNumberOfIdeas(result, followersIds)
  result = await getNumberOfLikes(result, followersIds)

  if (req.user) {
    result = await getFollowingStatus(result, req.user.id, followersIds)
  }

  console.log(result)

  if (!result) {
    return helper.resSend(res, null, 'Error', 'Unknown error')
  } else {
    return helper.resSend(res, result)
  }
}))

async function getNumberOfFollowers(result, followersIds) {
  const numberOfFollowers = await prisma.follower.groupBy({
    by: ['followee_id'],
    where: {
      followee_id: { in: followersIds }
    },
    _count: {
      follower_id: true
    }
  })

  result.forEach(function (obj) {
    numberOfFollowers.forEach(function (obj2) {
      if (obj.user.id === obj2.followee_id) {
        obj.user.numberOfFollowers = obj2._count.follower_id
      }
    })
  })
  return result
}

async function getNumberOfIdeas(result, followersIds) {
  const numberOfIdeas = await prisma.post.groupBy({
    by: ['fk_owner_user_id'],
    where: {
      fk_owner_user_id: { in: followersIds }
    },
    _count: {
      id: true
    }
  })

  result.forEach(function (obj) {
    numberOfIdeas.forEach(function (obj2) {
      if (obj.user.id === obj2.fk_owner_user_id) {
        obj.user.numberOfPosts = obj2._count.id
      }
    })
  })
  return result
}

async function getNumberOfLikes(result, followersIds) {
  const numberOfLikesPerPost = await prisma.vote.groupBy({
    by: ['post_id'],
    where: {
      post: {
        fk_owner_user_id: { in: followersIds }
      },
      value: 1
    },
    _sum: {
      value: true
    }
  })

  const postOwners = await prisma.post.findMany({
    where: {
      fk_owner_user_id: { in: followersIds }
    },
    select: {
      id: true,
      fk_owner_user_id: true
    }
  })

  const numberOfLikes = []

  for (let i = 0; i < postOwners.length; i++) {
    if (numberOfLikes.filter(e => e.ownerId === postOwners[i].fk_owner_user_id).length === 0) {
      numberOfLikes.push({
        ownerId: postOwners[i].fk_owner_user_id,
        numberOfLikes: numberOfLikesPerPost.find(e => e.post_id === postOwners[i].id)._sum.value
      })
    } else {
      numberOfLikes.find(e => e.ownerId === postOwners[i].fk_owner_user_id).numberOfLikes += numberOfLikesPerPost.find(e => e.post_id === postOwners[i].id)?._sum.value
    }
  }

  result.forEach(function (obj) {
    numberOfLikes.forEach(function (obj2) {
      if (obj.user.id === obj2.ownerId) {
        obj.user.numberOfLikes = obj2.numberOfLikes
      }
    })
  })
  return result
}

async function getFollowingStatus(result, userId, followersIds) {
  const followingStatus = await prisma.follower.findMany({
    where: {
      followee_id: { in: followersIds },
      follower_id: userId
    },
    select: {
      followee_id: true
    }
  })
  console.log(followingStatus)
  result.forEach(function (obj) {
    followingStatus.forEach(function (obj2) {
      if (obj.user.id === obj2.followee_id) {
        obj.user.following = true
      }
    })
  })
  return result
}

module.exports = router
