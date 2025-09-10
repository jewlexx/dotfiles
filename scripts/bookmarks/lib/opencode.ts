function openCode(gitUrl: string) {
  const url = new URL(gitUrl);
  for (const key in url.searchParams.keys()) {
    url.searchParams.delete(key);
  }
  url.hash = "";

  window.open(`https://vscode.dev/#${url.toString()}`, "_blank");
}

const url = window.location.href;

if (url.includes("github.com")) {
  openCode(url);
} else {
  alert("Invalid url. Please open a GitHub repository and try again.");
}
