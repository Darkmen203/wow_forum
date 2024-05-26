const defaultTheme = require('tailwindcss/defaultTheme')

module.exports = {
  content: [
    './public/*.html',
    './app/helpers/**/*.rb',
    './app/javascript/**/*.js',
    './app/views/**/*.{erb,haml,html,slim}'
  ],
  theme: {
    extend: {
      fontFamily: {
        sans: ['Inter var', ...defaultTheme.fontFamily.sans],
      },
      colors: {
        clifford: '#da373d',
      },
      backgroundImage: {
        'custom-gradient': 'linear-gradient(to bottom, #57a5de 0%, #047fbd 100%)',
      },
      height: {
        'screen-without-header': 'calc(100vh-2.5rem)',
      },
      backgroundColor: {
        'btn-color': 'rgb(150, 216, 253)',
        'formTitle': 'rgb(242, 205, 255)',
      },
    },
  },
  plugins: [
    require('@tailwindcss/forms'),
    require('@tailwindcss/typography'),
    require('@tailwindcss/container-queries'),
  ]
}
