import type { NextAuthConfig } from "next-auth";
import credentials from "next-auth/providers/credentials";
import { LoginSchema } from "./zod-schemas";
import prisma from "./utils/prisma";
import bcrypt from "bcrypt";

export default {
  providers: [
    credentials({
      async authorize(credentials) {
        const validatedFields = LoginSchema.safeParse(credentials);

        if (validatedFields.success) {
          const { name, password } = validatedFields.data;

          const user = await prisma.user.findUnique({ where: { name } });

          if (!user || !user.password) return null;

          const passwordsMatch = await bcrypt.compare(password, user.password);
          if (passwordsMatch) return user;
        }

        return null;
      },
    }),
  ],
} satisfies NextAuthConfig;
