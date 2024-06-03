import { z } from "zod";

export const LoginSchema = z.object({
  name: z
    .string()
    .min(1, "Este campo é obrigatório!")
    .refine((val) => val.toLowerCase()),
  password: z
    .string()
    .min(1, "Este campo é obrigatório!")
    .refine((val) => val.toLowerCase()),
});

export const RegisterSchema = z
  .object({
    name: z.string().min(2, "O usuário deve possuir no mínimo 2 caracteres"),
    email: z.string().optional(),
    password: z
      .string()
      .min(4, "A senha deve conter pelo menos 4 caracteres")
      .max(12, "A senha não deve conter mais do que 12 caracteres"),
    confirmPassword: z
      .string()
      .min(4, "A senha deve conter pelo menos 4 caracteres")
      .max(12, "A senha não deve conter mais do que 12 caracteres"),
  })
  .refine((data) => data.password === data.confirmPassword, {
    message: "As senhas devem ser iguais!",
    path: ["confirmPassword"], // path of error
  });

export type ILogin = z.infer<typeof LoginSchema>;
export type IRegister = z.infer<typeof RegisterSchema>;
