const text = window.prompt("Enter a string to count the words:");

if (!text) {
  window.alert("Please enter a string.");
} else {
  const words = text
    .split(" ")
    .filter((word) => !/^\s+$/.test(word) && word !== "").length;

  navigator.clipboard
    .writeText(words.toString())
    .catch(console.error)
    .finally(() => {
      window.alert(`The there are ${words} words in that string.`);
    });
}
