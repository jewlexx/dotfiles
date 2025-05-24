import { resolve } from "path";
import { defineConfig } from "vite";

import bookmarklet from "./plugins/bookmarklet";

export default defineConfig({
  build: {
    lib: {
      formats: ["es"],
      entry: {
        opencode: resolve(__dirname, "lib/opencode.ts"),
        reverse: resolve(__dirname, "lib/reverse.ts"),
        wordcount: resolve(__dirname, "lib/wordcount.ts"),
      },
    },
  },
  plugins: [bookmarklet()],
});
