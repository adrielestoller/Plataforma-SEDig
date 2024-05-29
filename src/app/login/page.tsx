"use client";

import { useForm, SubmitHandler } from "react-hook-form";
import { zodResolver } from "@hookform/resolvers/zod";
import { useState } from "react";
import { Eye, EyeOff } from "lucide-react";

import { LoginSchema, ILogin } from "@/common/zod-schemas";

export default function LoginPage() {
  const [passwordShow, setPasswordShow] = useState(false);
  const togglePasswordVisiblity = () => {
    setPasswordShow(passwordShow ? false : true);
  };

  const form = useForm<ILogin>({
    defaultValues: {
      user: "",
      password: "",
    },
    resolver: zodResolver(LoginSchema),
  });
  const {
    register,
    handleSubmit,
    formState: { errors, isSubmitSuccessful },
  } = form;

  const onSubmit: SubmitHandler<ILogin> = (data) => console.log(data);

  console.log(errors);
  console.log();
  return (
    <section className="h-screen flex flex-col gap-5 items-center justify-center">
      <h1 className="font-bold text-2xl">Login de Usuário</h1>
      <form
        className="flex flex-col gap-3 w-fit md:w-1/2"
        onSubmit={handleSubmit(onSubmit)}
      >
        <label className="text-xl">Usuário: </label>
        <input
          name="user"
          placeholder="Digite o nome de usuário"
          type="text"
          className="border rounded-md p-2"
        />
        {errors.user && (
          <span className="text-red-500">{errors.user?.message}*</span>
        )}

        <label className="text-xl">Senha: </label>
        <div className="border rounded-md p-2 flex justify-between outline-2 focus-within:outline">
          <input
            name="password"
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
          <span className="text-red-500">{errors.password?.message}*</span>
        )}
        <input
          type="submit"
          placeholder="Entrar"
          className="border-r-2 p-2 rounded-sm cursor-pointer hover:bg-cyan-700 duration-100 bg-cyan-500 text-white"
        />
      </form>
    </section>
  );
}
