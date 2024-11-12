import { Rustup } from "./tools/rustup.ts";

export function add(a: number, b: number): number {
  return a + b;
}

if (import.meta.main) {
  const rustup = new Rustup();
  rustup.pacman_install();
}
