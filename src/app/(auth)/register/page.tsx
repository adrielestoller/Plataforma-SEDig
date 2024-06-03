"use client";

import { useForm } from "react-hook-form";
import { zodResolver } from "@hookform/resolvers/zod";
import { Eye, EyeOff } from "lucide-react";
import { useState } from "react";
import { useTransition } from "react";

import { RegisterSchema, IRegister } from "@/lib/zod-schemas";
import { registerUser } from "./_actions/register";
import { redirect } from "next/navigation";

export default function RegisterPage() {
  const [isPending, startTransition] = useTransition();
  const [error, setError] = useState("");
  const [success, setSuccess] = useState("");
  const [passwordShow, setPasswordShow] = useState(false);
  const [confirmPasswordShow, setConfirmPasswordShow] = useState(false);

  const togglePasswordVisiblity = () => {
    setPasswordShow(passwordShow ? false : true);
  };

  const toggleConfirmPasswordVisiblity = () => {
    setConfirmPasswordShow(confirmPasswordShow ? false : true);
  };

  const form = useForm<IRegister>({
    resolver: zodResolver(RegisterSchema),
    defaultValues: {
      email: undefined,
    },
  });

  const {
    register,
    handleSubmit,
    formState: { errors, isSubmitSuccessful },
  } = form;

  const onSubmit = (values: IRegister) => {
    console.log("kek");
    startTransition(async () => {
      const data = await registerUser(values);
      if (data && data.success) {
        setSuccess(data.success);
        setError("");
        redirect("/");
      }
      if (data && data.error) {
        setError(data.error);
        setSuccess("");
      }
    });
  };

  return (
    <section className="h-screen flex flex-col gap-5 items-center justify-center">
      <h1 className="font-bold text-2xl">Cadastro de Usuário</h1>
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

        <label className="text-xl">Email: </label>
        <input
          {...register("email")}
          placeholder="Digite o email do usuário"
          type="email"
          className="border rounded-md p-2"
        />
        {errors.email && (
          <span className="text-red-500">{errors.email?.message} *</span>
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

        <label className="text-xl">Confirme a senha: </label>
        <div className="border rounded-md p-2 flex justify-between outline-2 focus-within:outline">
          <input
            {...register("confirmPassword")}
            className="outline-none w-full"
            placeholder="Digite a senha do usuário"
            type={confirmPasswordShow ? "text" : "password"}
          />
          <span className="text-gray-400 max-w-5 mx-2">
            {confirmPasswordShow ? (
              <Eye onClick={toggleConfirmPasswordVisiblity} />
            ) : (
              <EyeOff onClick={toggleConfirmPasswordVisiblity} />
            )}
          </span>
        </div>
        {errors.confirmPassword && (
          <span className="text-red-500">
            {errors.confirmPassword?.message} *
          </span>
        )}

        <button
          disabled={!form.formState.isValid}
          type="submit"
          className="border-r-2 p-2 rounded-sm active:cursor-pointer active:hover:bg-cyan-700 duration-100 bg-cyan-500 text-white disabled:bg-cyan-900 disabled:cursor-not-allowed"
        >
          Entrar
        </button>

        {success && !error && (
          <div className="bg-green-500 text-white px-4 py-2 rounded-md">
            {success}
          </div>
        )}
        {error && (
          <div className="bg-red-500  text-white px-4 py-2 rounded-md">
            {error}
          </div>
        )}
      </form>
    </section>
  );
}
