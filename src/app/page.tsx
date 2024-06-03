import { auth } from "@/lib/utils/auth";
import { signOut } from "@/lib/utils/auth";
import { redirect } from "next/navigation";
import prisma from "@/lib/utils/prisma";
import { json } from "stream/consumers";

export default async function Home() {
  let user = undefined;
  const session = await auth();
  if (session) {
    user = session.user;
  } else {
    return redirect("/login");
  }

  let name = user?.name || undefined;
  user = await prisma?.user.findUnique({
    where: { name },
  });

  var budgets = await prisma?.budget.findMany({ where: { userId: user?.id } });

  return (
    <main>
      <h1>Dashboard</h1>
      {JSON.stringify(session)}
      <form
        className="border bg-red-500 w-fit p-2 text-white rounded-md"
        action={async () => {
          "use server";
          await signOut();
        }}
      >
        <button type="submit"> Sign out</button>
      </form>

      <h1 className="bg-green-500 text-2xl">{user?.name}</h1>
      <div>{JSON.stringify(budgets)}</div>
    </main>
  );
}
