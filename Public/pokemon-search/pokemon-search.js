const searchButton = document.getElementById('search-button');

const cardPokemonName = document.getElementById('pokemon-name');
const cardPokemonId = document.getElementById('pokemon-id');
const cardPokemonWeight = document.getElementById('weight');
const cardPokemonHeight = document.getElementById('height');
const cardPokemonTypes = document.getElementById('types');
const cardPokemonHp = document.getElementById('hp');
const cardPokemonAttack = document.getElementById('attack');
const cardPokemonDefense = document.getElementById('defense');
const cardPokemonSpecialAttack = document.getElementById('special-attack');
const cardPokemonSpecialDefense = document.getElementById('special-defense');
const cardPokemonSpeed = document.getElementById('speed');

const pokemonListUrl = "https://pokeapi-proxy.freecodecamp.rocks/api/pokemon";

Object.defineProperty(String.prototype, 'capitalize', {
        value: function() {
          return this.charAt(0).toUpperCase() + this.slice(1);
        },
        enumerable: false
      });
    
const getPokemonData = async (pokemonName) => {
  try {
    let url;
    if (!isNaN(pokemonName)) { 
      url = `${pokemonListUrl}/${pokemonName}`;
    } else { 
      url = `${pokemonListUrl}/${pokemonName.toLowerCase()}`;
    }

    const response = await fetch(url);
    const data = await response.json();
    return data;
  } catch (err) {
    console.error(err);
  }
};

const showPokemon = async (event) => {
  event.preventDefault();
  const input = document.getElementById('search-input');
  const pokemonName = input.value;
  
  if (!pokemonName) {
    alert("Pokemon not found");
    return;
  }

  const pokemonData = await getPokemonData(pokemonName);
  if (pokemonData) {
    const { name, id, weight, height, types, stats, sprites } = pokemonData;
    const hp = stats.find(stat => stat.stat.name === 'hp').base_stat;
    const attack = stats.find(stat => stat.stat.name === 'attack').base_stat;
    const defense = stats.find(stat => stat.stat.name === 'defense').base_stat;
    const specialAttack = stats.find(stat => stat.stat.name === 'special-attack').base_stat;
    const specialDefense = stats.find(stat => stat.stat.name === 'special-defense').base_stat;
    const speed = stats.find(stat => stat.stat.name === 'speed').base_stat;

    
    cardPokemonTypes.innerHTML = ''; 
    cardPokemonName.innerHTML = name.capitalize();
    cardPokemonId.innerHTML = id;
    cardPokemonWeight.innerHTML = weight;
    cardPokemonHeight.innerHTML = height;
    cardPokemonHp.innerHTML = hp;
    cardPokemonAttack.innerHTML = attack;
    cardPokemonDefense.innerHTML = defense;
    cardPokemonSpecialAttack.innerHTML = specialAttack;
    cardPokemonSpecialDefense.innerHTML = specialDefense;
    cardPokemonSpeed.innerHTML = speed;

     types.forEach(type => {
      const typeElement = document.createElement('p');
      typeElement.textContent = type.type.name.capitalize();
      cardPokemonTypes.appendChild(typeElement);
    });

   const spriteBackground = document.getElementById("sprite-background");
   spriteBackground.style.display = "block";

   const existingSprite = document.getElementById('sprite');
    if (existingSprite) {
      existingSprite.remove();
    }

    
    const spriteElement = document.createElement('img');
    spriteElement.id = 'sprite';
    spriteElement.src = sprites.front_default;
    document.body.appendChild(spriteElement);
  } else {
    alert('Pokémon not found');
  }
};

searchButton.addEventListener('click', showPokemon);
