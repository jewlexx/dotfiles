import { type PluginOption } from "vite";

export default function bookmarklet(): PluginOption {
  return {
    name: "bookmarklet",
    enforce: "post",
    generateBundle(_options, bundle) {
      for (const module of Object.values(bundle)) {
        if (module.type === "chunk") {
          module.code = `javascript:(function(){${module.code}})();`;
        }
      }
    },
  };
}
