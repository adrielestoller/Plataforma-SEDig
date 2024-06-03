import authConfig from "@/lib/auth.config";
import NextAuth from "next-auth";

const { auth } = NextAuth(authConfig);
const authRoutes = ["/login", "/register"];

export default auth((req) => {
  const isLoggedIn = !!req.auth;
  const isAuthRoute = authRoutes.includes(req.nextUrl.pathname);
  const isApiAuthRouter = req.nextUrl.pathname.startsWith("/api");

  if (isApiAuthRouter) {
    return;
  }

  if (isAuthRoute) {
    if (isLoggedIn) {
      return Response.redirect(new URL("/", req.nextUrl));
    }
    return;
  }
  if (!isLoggedIn && !isAuthRoute) {
    return Response.redirect(new URL("/login", req.nextUrl));
  }

  return;
});

export const config = {
  matcher: ["/((?!api|_next/static|_next/image|favicon.ico).*)"],
};
