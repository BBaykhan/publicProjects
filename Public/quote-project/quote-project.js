const tweetQuote = document.getElementById("tweet-quote");
const quoteGet = document.getElementById("new-quote");
const authorText = document.getElementById("author");
const quoteText = document.getElementById("quote");
const quoteList = "https://gist.githubusercontent.com/nasrulhazim/54b659e43b1035215cd0ba1d4577ee80/raw/e3c6895ce42069f0ee7e991229064f167fe8ccdc/quotes.json";

let quotes = [];

function getRandomQuote() {
    const randomIndex = Math.floor(Math.random() * quotes.length);
    const randomQuote = quotes[randomIndex];

    quoteText.classList.add('flip');
    authorText.classList.add('flip');

    setTimeout(() => {
        quoteText.textContent = randomQuote.quote;
        authorText.textContent = `~ ${randomQuote.author} ~`;

        quoteText.classList.remove('flip'); 
        authorText.classList.remove('flip');

        tweetQuote.href = `https://twitter.com/intent/tweet?text="${encodeURIComponent(randomQuote.quote)}" - ${encodeURIComponent(randomQuote.author)}`;
    }, 400); 
}

quoteGet.addEventListener('click', () => {

    quoteGet.style.transition = "transform 0.8s ease";
    quoteGet.style.transform = "translateY(170px)";
    
    setTimeout(() => {
        quoteGet.style.transform = "translateY(0)";
    }, 800);

    getRandomQuote();
});

fetch(quoteList)
    .then(response => response.json())
    .then(data => {
        quotes = data.quotes;
        getRandomQuote();
    })
    .catch(error => {
        console.error('Error fetching:', error);
    });