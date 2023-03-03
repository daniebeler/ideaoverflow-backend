const { PrismaClient } = require('@prisma/client')
const prisma = new PrismaClient()

module.exports = {
  getNumberOfFollowersByUserid: async function (userId) {
    const numberOfFollowers = await prisma.follower.count({
      where: {
        followee_id: userId ?? -1
      }
    })

    return numberOfFollowers ?? 0
  },

  getNumberOfFolloweesByUserid: async function (userId) {
    const numberOfFollowees = await prisma.follower.count({
      where: {
        follower_id: userId ?? -1
      }
    })

    return numberOfFollowees ?? 0
  },

  getNumberOfIdeasByUserid: async function (userId) {
    const numberOfIdeas = await prisma.post.count({
      where: {
        fk_owner_user_id: userId ?? -1
      }
    })

    return numberOfIdeas ?? 0
  },

  getNumberOfProjectsByUserid: async function (userId) {
    const numberOfProjects = await prisma.project.count({
      where: {
        fk_user_id: userId ?? -1
      }
    })

    return numberOfProjects ?? 0
  }
}
