let original = window.prompt("Enter the string to reverse");

if (!original) {
  window.alert("Please enter a string to reverse.");
} else {
  const reversed = original.split("").reverse().join("");

  navigator.clipboard.writeText(reversed).finally(() => {
    window.alert(`The reversed string is: ${reversed}`);
  });
}
