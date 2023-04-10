module.exports = {
  content: [
    './public/*.html',
    './app/helpers/**/*.rb',
    './app/javascript/**/*.js',
    './app/views/**/*',
    './node_modules/flowbite/**/*.js'
  ],
  darkMode: "class",
  theme: {
    extend: {
      colors: {
        primary: { "50": "#eefffc", "100": "#c5fffa", "200": "#8bfff5", "300": "#4afef0", "400": "#15ece2", "500": "#00d0c9", "600": "#00a8a5", "700": "#008080", "800": "#066769", "900": "#0a5757", "950":"#003235" }, 
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
