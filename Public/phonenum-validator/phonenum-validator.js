const checkBtn = document.getElementById("check-btn");
const clearBtn = document.getElementById("clear-btn");
const input = document.getElementById("user-input");
const result = document.getElementById("results-div")



checkBtn.addEventListener("click", function(event) {
  event.preventDefault();
  const textP = input.value;
  if (!textP) return alert("Please provide a phone number");

  const invalidBracket = (textP.includes('(') !== textP.includes(')')) || textP.indexOf(')') < textP.indexOf('(');
  const invalidStartEnd = ["-", "?"].includes(textP[0]) || textP.includes('?');


  const dashCount = (textP.match(/-/g) || []).length;


  const improperBracketUsage = textP.includes('(') && textP.includes(')') && !textP.includes('-');

  if (invalidBracket || invalidStartEnd || dashCount > 2 || improperBracketUsage) {
    result.innerHTML = `Invalid US number: ${textP}`;
    return;
  }

  const cleanNumber = textP.replace(/\D/g, '');

 
  if (cleanNumber.length === 10 || (cleanNumber.length === 11 && cleanNumber[0] === "1")) {
    result.innerHTML = `Valid US number: ${textP}`;
  } else {
    result.innerHTML = `Invalid US number: ${textP}`;
  }
});

clearBtn.addEventListener("click", () => result.innerHTML = "");