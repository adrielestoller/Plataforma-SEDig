"use client";

import { useForm, SubmitHandler } from "react-hook-form";
import { zodResolver } from "@hookform/resolvers/zod";
import { useState } from "react";
import { Eye, EyeOff } from "lucide-react";
import { signIn } from "next-auth/react";

import { LoginSchema, ILogin } from "@/lib/zod-schemas";
import Link from "next/link";

export default function LoginPage() {
  const [error, setError] = useState<string | null>(null);
  const [passwordShow, setPasswordShow] = useState(false);
  const togglePasswordVisiblity = () => {
    setPasswordShow(passwordShow ? false : true);
  };

  const form = useForm<ILogin>({
    resolver: zodResolver(LoginSchema),
  });
  const {
    register,
    handleSubmit,
    formState: { errors, isSubmitSuccessful },
  } = form;

  const onSubmit: SubmitHandler<ILogin> = (data) => {
    const name = data.name;
    const password = data.password;

    signIn("credentials", {
      name,
      password,
      callbackUrl: "/",
      redirect: true,
    }).then((res) => {
      if (res && res.error === "CredentialsSignin") {
        setError("Credenciais Inválidas");
      }
    });
  };

  return (
    <section className="h-screen flex flex-col gap-5 items-center justify-center">
      <h1 className="font-bold text-2xl">Login de Usuário</h1>
      <form
        className="flex flex-col gap-3 w-fit md:w-1/2"
        onSubmit={handleSubmit(onSubmit)}
      >
        <label className="text-xl">Usuário: </label>
        <input
          {...register("name")}
          placeholder="Digite o nome de usuário"
          type="text"
          className="border rounded-md p-2"
        />
        {errors.name && (
          <span className="text-red-500">{errors.name?.message} *</span>
        )}

        <label className="text-xl">Senha: </label>
        <div className="border rounded-md p-2 flex justify-between outline-2 focus-within:outline">
          <input
            {...register("password")}
            className="outline-none w-full"
            placeholder="Digite a senha do usuário"
            type={passwordShow ? "text" : "password"}
          />
          <span className="text-gray-400 max-w-5 mx-2">
            {passwordShow ? (
              <Eye onClick={togglePasswordVisiblity} />
            ) : (
              <EyeOff onClick={togglePasswordVisiblity} />
            )}
          </span>
        </div>
        {errors.password && (
          <span className="text-red-500">{errors.password?.message} *</span>
        )}

        <button
          disabled={!form.formState.isValid}
          type="submit"
          className="border-r-2 p-2 rounded-sm active:cursor-pointer active:hover:bg-cyan-700 duration-100 bg-cyan-500 text-white disabled:bg-cyan-900 disabled:cursor-not-allowed"
        >
          Entrar
        </button>

        <span className="text-center">
          Ainda não tem registro?{" "}
          <Link href="/register" className="text-cyan-700">
            Registre-se!
          </Link>
        </span>

        {error && (
          <div className="bg-red-500  text-white px-4 py-2 rounded-md">
            {error}
          </div>
        )}
      </form>
    </section>
  );
}
