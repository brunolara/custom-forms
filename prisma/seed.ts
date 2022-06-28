import { PrismaClient } from '@prisma/client'
import bcryptjs from 'bcryptjs' 
const prisma = new PrismaClient()

async function main() {
    await prisma.user.create(
        {
            data:  {
                name: 'Bruno',
                email: 'bru.lara@live.com',
                password: bcryptjs.hashSync('123456'),
                formConfigs: {
                    create: {
						title: "Form doido",
						fields:{
							create:{
								name: 'ronaldo',
								label: 'adriano',
								field_type_id: 1,
							
							}
						}
					  }
                }
            }
        }
    )
  }
  
  main()
    .catch((e) => {
      console.error(e)
      process.exit(1)
    })
    .then(async () => {
      await prisma.$disconnect()
    })