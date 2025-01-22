const palindromeForm = document.getElementById("palindrome-form");
const textInput = document.getElementById("text-input");
const textP = document.getElementById("result");

palindromeForm.addEventListener("submit", function(event) {
  event.preventDefault();

  const text = textInput.value.trim().toLowerCase();

  if (text === "") {
    alert("Please input a value");
    return;
  } 

  const cleanedText = text.replace(/[^a-z0-9]/gi,'');
  const reversedText = cleanedText.split("").reverse().join("");

  if (cleanedText === reversedText) {
    textP.innerText = `${textInput.value} is a palindrome`
  } else {
    textP.innerText = `${textInput.value} is not a palindrome`
  }
});
  