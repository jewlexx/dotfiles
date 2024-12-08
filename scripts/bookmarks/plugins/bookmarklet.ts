import { type PluginOption } from "vite";

export default function bookmarklet(): PluginOption {
  return {
    name: "bookmarklet",
    enforce: "pre",
    transform(code, id) {
      if (id.endsWith(".ts")) {
        return `javascript:{(function(){${code}})();break javascript;}`;
      }
    },
  };
}
