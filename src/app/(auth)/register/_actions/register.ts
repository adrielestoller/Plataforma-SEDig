"use server";

import prisma from "@/lib/utils/prisma";
import { IRegister, RegisterSchema } from "@/lib/zod-schemas";
import { hashSync } from "bcrypt";
import { redirect } from "next/navigation";
import bcrypt from "bcrypt";
import path from "path";
import { isEmpty } from "validator";
import { string } from "zod";

export const registerUser = async (values: IRegister) => {
  const validatedFields = RegisterSchema.safeParse(values);
  if (!validatedFields.success) {
    return {
      error: "Campos inválidos!",
      path: "errors",
    };
  }

  const { name, email, password } = validatedFields.data;
  const hashedPassword = await bcrypt.hash(password, 12);
  const existingUser = await prisma.user.findUnique({
    where: { name },
  });

  if (existingUser) {
    return {
      error: "Este usuário já existe!",
      path: "errors",
    };
  }

  const existingEmail = await prisma.user.findUnique({
    where: { email },
  });

  console.log(email + "kek");
  console.log(typeof email);

  if (email != "") {
    if (existingEmail) {
      return {
        error: "Este email já está em uso!",
        path: "errors",
      };
    }
  }

  try {
    await prisma.user.create({
      data: {
        name,
        email,
        password: hashedPassword,
      },
    });
  } catch {
    await prisma.user.create({
      data: {
        name,
        password: hashedPassword,
      },
    });
  }
  return {
    success: "Usuário criado com sucesso!",
    path: "errors",
  };
};
