import { z } from "zod";

export const LoginSchema = z.object({
  user: z
    .string()
    .min(1, "Este campo é obrigatório!")
    .trim()
    .refine((val) => val.toLowerCase()),
  password: z
    .string()
    .min(1, "Este campo é obrigatório!")
    .trim()
    .refine((val) => val.toLowerCase()),
});

export const SignUpSchema = z.object({
  user: z
    .string()
    .min(1, "Este campo é obrigatório!")
    .trim()
    .refine((val) => val.toLowerCase()),
  email: z.string().email("Insira um email válido!").optional(),
  password: z
    .string()
    .min(1, "Este campo é obrigatório!")
    .trim()
    .refine((val) => val.toLowerCase()),
});

export type ILogin = z.infer<typeof LoginSchema>;
export type ISignUp = z.infer<typeof SignUpSchema>;
