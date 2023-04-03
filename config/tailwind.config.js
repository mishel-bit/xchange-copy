const defaultTheme = require('tailwindcss/defaultTheme')

module.exports = {
  content: [
    './public/*.html',
    './app/helpers/**/*.rb',
    './app/javascript/**/*.js',
    './app/views/**/*',
    './node_modules/flowbite/**/*.js'
  ],
  darkMode: "class",
  darkMode: 'media',
  theme: {
    extend: {
      colors: {
        primary: { "50": "#f3faf7", "100": "#d8efe8", "200": "#b2ddd1", "300": "#83c5b5", "400": "#5aa897", "500": "#408c7d", "600": "#317065", "700": "#2a5b52", "800": "#254a44", "900": "#233e3a" }, 
        secondary: { "50": "#fef5f2", "100": "#fee9e2", "200": "#fed7ca", "300": "#fbbba6", "400": "#f8a488", "500": "#ed7046", "600": "#da5528", "700": "#b8441d", "800": "#983b1c", "900": "#7e361e" }
      },
      fontFamily: {
        
        'sans': ['Rubik, sans-serif'],
        'body': ['Rubik, sans-serif'],
        'mono': ['SFMono-Regular', 'Menlo', 'Monaco', 'Consolas', 'Liberation Mono', 'Courier New', 'monospace']
      },

      transitionProperty: {
        'width': 'width'
      },
      textDecoration: ['active'],
      minWidth: {
        'kanban': '28rem'
      },
    },
  },
  plugins: [
    require('@tailwindcss/forms'),
    require('@tailwindcss/aspect-ratio'),
    require('@tailwindcss/typography'),
    require('@tailwindcss/container-queries'),
    require('flowbite/plugin')
  ]
}
