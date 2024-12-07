javascript: {
  void 0;

  function openCode(gitUrl) {
    const url = new URL(gitUrl);
    url.searchParams = new URLSearchParams();
    url.hash = "";

    window.open(`https://vscode.dev/#${url.toString()}`, "_blank");
  }

  const url = window.location.href;

  if (url.includes("github.com")) {
    openCode(url);
  } else {
    alert("Invalid url. Please open a GitHub repository and try again.");
  }
}
