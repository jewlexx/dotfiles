javascript: {
  void 0;

  /** @type {string} */
  let original;
  while (true) {
    const originalTmp = window.prompt("Enter the string to reverse");

    if (original !== null) {
      original = originalTmp;
      break;
    }
  }

  const reversed = original.split("").reverse().join("");

  navigator.clipboard.writeText(reversed).finally(() => {
    window.alert(`The reversed string is: ${reversed}`);
  });
}
