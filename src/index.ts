import { PrismaClient } from '@prisma/client'

const prisma = new PrismaClient()

async function main() {
    const allUsers = await prisma.user.findMany();
    // use `console.dir` to print nested objects
    console.dir(allUsers, { depth: null })
}

main()
  .catch((e) => {
    throw e
  })
  .then(async () => {
    await prisma.$disconnect()
  });