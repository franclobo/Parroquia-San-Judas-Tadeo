import './style.scss';
import * as bootstrap from 'bootstrap'
import logo from './images/Tadeo.png';
import carousel from './images/Adviento.jpeg';
import carousel2 from './images/Adviento2.jpeg';

const headLogo = document.getElementById('logo');
const myLogo = new Image();
myLogo.src = logo;
headLogo.appendChild(myLogo);

const carouselOne = document.getElementById('carousel-item');
const myCarousel = new Image();
myCarousel.src = carousel;
carouselOne.appendChild(myCarousel);
carouselOne.classList.add('d-block w-100');

const carouselTwo = document.getElementById('carousel-item-one');
const myCarouselTwo = new Image();
myCarouselTwo.src = carousel2;
carouselTwo.appendChild(myCarouselTwo);
carouselTwo.classList.add('d-block w-100');

const carouselThree = document.getElementById('carousel-item-two');
const myCarouselThree = new Image();
myCarouselThree.src = logo;
carouselThree.appendChild(myCarouselThree);
carouselThree.classList.add('d-block w-100');

function component() {
  const element = document.createElement('div');
  const btn = document.createElement('button');

  return element;
}

document.body.appendChild(component());